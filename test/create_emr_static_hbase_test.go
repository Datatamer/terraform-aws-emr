package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

// EmrTestCase is a struct for defining tests for Elastic Map Reduce Module
type EmrTestCase struct {
	testName        string
	vars            map[string]interface{}
	expectPassApply bool
}

func initTestCases() []EmrTestCase {
	return []EmrTestCase{
		{
			testName: "Test1",
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
			expectPassApply: true,
		},
	}
}
func TestCreateEmrStaticHbaseCluster(t *testing.T) {
	// os.Setenv("SKIP_", "true")
	// os.Setenv("TERRATEST_REGION", "us-east-1")

	// For convenience - uncomment these as well as the "os" import
	// when doing local testing if you need to skip any sections.
	//
	// The good usage for skipping stages is local testing, when you want to make sure your test code is fine,
	// and not waste time building new infrastructure every time.
	// A nice approach for doing that would be:
	// 1- Make sure there are no local files in the dirs (`rm -rf .test-dir terraform.tfstate*`)
	// 2- Skip teardown* and run tests. (create and keep infrastructure, tfstate will be into local folders)
	// 3- In your next run skip `pick*` steps (which makes sure random values in Terratest state won't be updated)
	//    obs: if you forget and run tests once, you can make use of `terraform.tfstate.backup` file to restore it
	// 4- Run local Tests; Do your thing;
	// 5- When you are done and want to destroy the infrastructure -> comment back teardown* steps
	// 6- Comment back pick* steps.

	// os.Setenv("SKIP_pick_new_randoms", "true")
	// os.Setenv("SKIP_setup_options", "true")
	// os.Setenv("SKIP_create_bucket", "true")
	// os.Setenv("SKIP_validate", "true")

	// Warning: if you skip these steps, Terratest state will be stored in local folder under .test-data inside each TF dir you skip.
	// These are purposedly stored in the known TF dir (not tmp folder) to make sure you can re-run tests on them at any time.
	// Remember removing those folders after you finish your tests so that it won't affect the next time you run local tests.
	// os.Setenv("SKIP_teardown", "true")
	// os.Setenv("SKIP_teardown_role", "true")

	// list of different buckets that will be created to be tested
	testCases := initTestCases()

	// When using test_structure functions + parallel tests with random IDs we will run into consistency problems.
	// This is an easy/lazy way to deal with it.
	if test_structure.SkipStageEnvVarSet() && len(testCases) > 1 {
		logger.Log(t,
			"Won't run tests using SKIP_* vars having multiple cases. Temporary folders are disabled when using SKIP_* (local testing). Not having different folders for each testCase will generate conflicts with state files.")
		t.FailNow()
		// Another solution would be to simply truncate the list of cases instead of failing.
		// bucketTestCases = bucketTestCases[:1]
	}

	for _, testCase := range testCases {
		t.Parallel()
		// These will create a tempTestFolder for each bucketTestCase.
		// Also, if any of SKIP_* env vars are set, it won't create temp folders in order to store configuration that must be retained
		// through different local tests when skipping stages.
		// (e.g. `awsRegion` and `uniqueId`.
		tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, "..", "test_examples/static-hbase")

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
			terraform.InitAndApply(t, terraformOptions)
		})

		test_structure.RunTestStage(t, "validate", func() {
			terraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
			// brings all outputs inside a map
			outAll := terraform.OutputAll(t, terraformOptions)
			assert.NotNil(t, outAll)
		})
	}
}
