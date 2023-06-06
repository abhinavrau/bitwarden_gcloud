package test

import (
	"net"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestOwnWarndenEnd2End(t *testing.T) {

	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../",
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"end2end_test.tfvars"},
		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	//  Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	//  Run `terraform output` to get the values of output variables and check they have the expected values.
	output_instance_name := terraform.Output(t, terraformOptions, "instance_name")
	assert.Equal(t, "ownwarden-vm-01", output_instance_name)

	// validate IP address
	output_external_ip := terraform.Output(t, terraformOptions, "external_ip")
	assert.NotNil(t, net.ParseIP(output_external_ip))

}
