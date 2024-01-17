package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAwsLambda(t *testing.T) {
	t.Parallel()

	functionName := "terraform-and-terratest-aws-lambda-function"

	awsRegion := "us-east-1"
	responseLambda := "{\"statusCode\": 200, \"body\": \"\\\"Hello, Marco!\\\"\"}"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../resources/lambda/",

		Vars: map[string]interface{}{
			"function_name": functionName,
			"region":        awsRegion,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	response := aws.InvokeFunction(t, awsRegion, functionName, responseLambda)

	assert.Equal(t, responseLambda, string(response))
}
