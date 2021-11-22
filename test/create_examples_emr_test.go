package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func initTestCases() []EmrTestCase {
	return []EmrTestCase{
		{
			testName: "Hbase_Test_1",
			vars: map[string]interface{}{
				"vpc_cidr":            "172.22.0.0/20",
				"private_subnets":     []string{"172.22.1.0/24", "172.22.2.0/24"},
				"public_subnets":      []string{"172.22.3.0/24", "172.22.4.0/24"},
				"ingress_cidr_blocks": []string{"0.0.0.0/0"},
				"egress_cidr_blocks":  []string{"0.0.0.0/0"},
				"tags":                make(map[string]string),
				"abac_tags": map[string]string{
					"for-use-with-amazon-emr-managed-policies": "true",
				},
				"abac_valid_tags": make(map[string][]string),
			},
			expectApplyError: false,
			tfDir:            "test_examples/static-hbase",
		},
		{
			testName: "Spark_Test_1",
			vars: map[string]interface{}{
				"vpc_cidr":            "172.23.0.0/20",
				"private_subnets":     []string{"172.23.1.0/24", "172.23.2.0/24"},
				"public_subnets":      []string{"172.23.3.0/24", "172.23.4.0/24"},
				"ingress_cidr_blocks": []string{"0.0.0.0/0"},
				"egress_cidr_blocks":  []string{"0.0.0.0/0"},
				"tags":                make(map[string]string),
				"abac_tags": map[string]string{
					"for-use-with-amazon-emr-managed-policies": "true",
				},
				"abac_valid_tags": make(map[string][]string),
			},
			expectApplyError: false,
			tfDir:            "test_examples/static-spark",
		},
		{
			testName: "Ephem_Spark_Test_1",
			vars: map[string]interface{}{
				"vpc_cidr":       "172.24.0.0/20",
				"public_subnets": []string{"172.24.3.0/24", "172.24.4.0/24"},
				"tags":           make(map[string]string),
				"abac_tags": map[string]string{
					"for-use-with-amazon-emr-managed-policies": "true",
				},
				"abac_valid_tags": make(map[string][]string),
			},
			expectApplyError: false,
			tfDir:            "test_examples/ephemeral-spark",
		},
	}
}
func TestCreateExamplesEmr(t *testing.T) {
	// os.Setenv("TERRATEST_REGION", "us-east-1")

	testCases := initTestCases()

	for _, testCase := range testCases {
		testCase := testCase
		t.Run(testCase.testName, func(t *testing.T) {
			t.Parallel()
			// These will create a tempTestFolder for each bucketTestCase.
			tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, "..", testCase.tfDir)

			// this stage will generate a random `awsRegion` and a `uniqueId` to be used in tests.
			test_structure.RunTestStage(t, "pick_new_randoms", func() {
				// Pick a random AWS region to test in. This helps ensure your code works in all regions.
				usRegions := []string{"us-east-1", "us-east-2", "us-west-1", "us-west-2"}
				// This function will first check for the Env Var TERRATEST_REGION and return its value if != ""
				awsRegion := aws.GetRandomStableRegion(t, usRegions, nil)

				test_structure.SaveString(t, tempTestFolder, "region", awsRegion)
				test_structure.SaveString(t, tempTestFolder, "unique_id", strings.ToLower(random.UniqueId()))
			})

			defer test_structure.RunTestStage(t, "teardown", func() {
				teraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				terraform.Destroy(t, teraformOptions)
			})

			test_structure.RunTestStage(t, "setup_options", func() {
				awsRegion := test_structure.LoadString(t, tempTestFolder, "region")
				uniqueID := test_structure.LoadString(t, tempTestFolder, "unique_id")

				testCase.vars["name_prefix"] = fmt.Sprintf("terratest-%s", uniqueID)
				testCase.vars["bucket_name_for_root_directory"] = fmt.Sprintf("%s-%s", "hbase-terratest-root-dir", uniqueID)
				testCase.vars["bucket_name_for_logs"] = fmt.Sprintf("%s-%s", "hbase-terratest-logs", uniqueID)

				terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
					TerraformDir: tempTestFolder,
					Vars:         testCase.vars,
					EnvVars: map[string]string{
						"AWS_REGION": awsRegion,
					},
				})

				test_structure.SaveTerraformOptions(t, tempTestFolder, terraformOptions)
			})

			test_structure.RunTestStage(t, "create", func() {
				terraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				_, err := terraform.InitAndApplyE(t, terraformOptions)

				if testCase.expectApplyError {
					require.Error(t, err)
					// If it failed as expected, we should skip the rest (validate function).
					t.SkipNow()
				}
			})

			test_structure.RunTestStage(t, "validate", func() {
				terraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				// brings all outputs inside a map
				outAll := terraform.OutputAll(t, terraformOptions)
				require.NotNil(t, outAll)
				for _, o := range outAll {
					assert.NotNil(t, o)
				}
			})
		})
	}
}
