package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestModuleEmrIAM(t *testing.T) {
	t.Parallel()

	uniqueId := strings.ToLower(random.UniqueId())
	testVars := map[string]interface{}{
		"s3_bucket_name_for_logs":           fmt.Sprintf("%s-%s", uniqueId, "emr-terratest-logs"),
		"s3_bucket_name_for_root_directory": fmt.Sprintf("%s-%s", uniqueId, "emr-terratest-root"),
		"s3_policy_arns":                    []string{"arn:aws:iam::aws:policy/AmazonS3FullAccess"},
		"emr_ec2_iam_policy_name":           fmt.Sprintf("%s-%s", uniqueId, "terratest-ec2-policy"),
		"emr_service_iam_policy_name":       fmt.Sprintf("%s-%s", uniqueId, "terratest-service-policy"),
		"emr_service_role_name":             fmt.Sprintf("%s-%s", uniqueId, "terratest-service-role"),
		"emr_ec2_instance_profile_name":     fmt.Sprintf("%s-%s", uniqueId, "terratest-instance-profile"),
		"emr_ec2_role_name":                 fmt.Sprintf("%s-%s", uniqueId, "terratest-ec2-role"),
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../test_examples/module_emr-iam",
		Vars:         testVars,
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// brings all outputs inside a map
	outAll := terraform.OutputAll(t, terraformOptions)
	assert.NotNil(t, outAll)
}