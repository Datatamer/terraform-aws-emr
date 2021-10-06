package test

// EmrTestCase is a struct for defining tests for Elastic Map Reduce Module
type EmrTestCase struct {
	testName         string
	vars             map[string]interface{}
	expectApplyError bool
	tfDir            string
}
