package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// EmrTestCase is a struct for defining tests for Elastic Map Reduce Module
type EmrTestCase struct {
	testName         string
	vars             map[string]interface{}
	expectApplyError bool
	tfDir            string
}

func validateModuleOutputs(t *testing.T, terraformOptions *terraform.Options) {
	// brings all outputs inside a map
	outAll := terraform.OutputAll(t, terraformOptions)
	require.NotNil(t, outAll)
	for _, o := range outAll {
		assert.NotNil(t, o)
	}
}
