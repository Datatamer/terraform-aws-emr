package test

import (
	"fmt"
	"os"
	"strings"
	"testing"

	terratestutils "github.com/Datatamer/go-terratest-functions/pkg/terratest_utils"
	"github.com/Datatamer/go-terratest-functions/pkg/types"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestModuleEmrIAM(t *testing.T) {
	const MODULE_NAME = "terraform-aws-emr"
	t.Parallel()

	uniqueId := strings.ToLower(random.UniqueId())

	usRegions := []string{"us-east-1", "us-east-2", "us-west-1", "us-west-2"}
	// This function will first check for the Env Var TERRATEST_REGION and return its value if != ""
	awsRegion := aws.GetRandomStableRegion(t, usRegions, nil)
	// Generate file containing GCS URL to be used on Jenkins.
	// TERRATEST_BACKEND_BUCKET_NAME and TERRATEST_URL_FILE_NAME are both set on Jenkins declaration.
	gcsTestExamplesURL := terratestutils.GenerateUrlFile(t, MODULE_NAME, os.Getenv("TERRATEST_BACKEND_BUCKET_NAME"), os.Getenv("TERRATEST_URL_FILE_NAME"))

	testVars := map[string]interface{}{
		"s3_bucket_name_for_logs":           fmt.Sprintf("%s-%s", uniqueId, "emr-terratest-logs"),
		"s3_bucket_name_for_root_directory": fmt.Sprintf("%s-%s", uniqueId, "emr-terratest-root"),
		"additional_policy_arns":            []string{"arn:aws:iam::aws:policy/AmazonS3FullAccess"},
		"emr_ec2_iam_policy_name":           fmt.Sprintf("%s-%s", uniqueId, "terratest-ec2-policy"),
		"emr_service_iam_policy_name":       fmt.Sprintf("%s-%s", uniqueId, "terratest-service-policy"),
		"emr_service_role_name":             fmt.Sprintf("%s-%s", uniqueId, "terratest-service-role"),
		"emr_ec2_instance_profile_name":     fmt.Sprintf("%s-%s", uniqueId, "terratest-instance-profile"),
		"emr_ec2_role_name":                 fmt.Sprintf("%s-%s", uniqueId, "terratest-ec2-role"),
	}
	backendConfig := terratestutils.ParseBackendConfig(t, gcsTestExamplesURL, "emr-iam-test", "test_examples/module_emr-iam")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../test_examples/module_emr-iam",
		Vars:         testVars,
		EnvVars: map[string]string{
			"AWS_REGION": awsRegion,
		},
		BackendConfig: backendConfig,
		MaxRetries:    5,
	})
	terraformConfig := &types.TerraformData{
		TerraformBackendConfig: terraformOptions.BackendConfig,
		TerraformVars:          terraformOptions.Vars,
		TerraformEnvVars:       terraformOptions.EnvVars,
	}
	if _, err := terratestutils.UploadFilesE(t, terraformConfig); err != nil {
		logger.Log(t, err)
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// brings all outputs inside a map
	outAll := terraform.OutputAll(t, terraformOptions)
	assert.NotNil(t, outAll)
}
