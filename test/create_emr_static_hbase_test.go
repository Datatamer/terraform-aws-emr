package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformCreateSG(t *testing.T) {
	t.Parallel()

	namePrefix := fmt.Sprintf("%s-%s", "terratest", strings.ToLower(random.UniqueId()))

	bucketRootDirName := fmt.Sprintf("%s-%s", namePrefix, "hbase-test-root-directory-bucket")
	bucketLogsName := fmt.Sprintf("%s-%s", namePrefix, "hbase-test-logs-bucket")

	// Getting a random region between the US ones
	awsRegion := aws.GetRandomRegion(t, []string{"us-east-1", "us-east-2", "us-west-1", "us-west-2"}, nil)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../test_examples/test_static-hbase",

		Vars: map[string]interface{}{
			"bucket_name_for_root_directory": bucketRootDirName,
			"bucket_name_for_logs":           bucketLogsName,
		},
		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// brings all outputs inside a map
	outAll := terraform.OutputAll(t, terraformOptions)
	assert.NotNil(t, outAll)

}
