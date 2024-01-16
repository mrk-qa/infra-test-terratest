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

func TestTerraformAwsRds(t *testing.T) {
	t.Parallel()

	expectedName := fmt.Sprintf("terratestawsrds%s", strings.ToLower(random.UniqueId()))
	expectedPort := int64(3306)
	expectedDatabaseName := "marcoqadb123"
	username := "marcoqadb"
	password := "12345678"
	awsRegion := "us-east-1"
	engineVersion := aws.GetValidEngineVersion(t, awsRegion, "mysql", "5.7")
	instanceType := aws.GetRecommendedRdsInstanceType(t, awsRegion, "mysql", engineVersion, []string{"db.t2.micro"})

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../resources/db/",

		Vars: map[string]interface{}{
			"name":                 expectedName,
			"engine_name":          "mysql",
			"major_engine_version": "5.7",
			"family":               "mysql5.7",
			"instance_class":       instanceType,
			"username":             username,
			"password":             password,
			"allocated_storage":    5,
			"license_model":        "general-public-license",
			"engine_version":       engineVersion,
			"port":                 expectedPort,
			"database_name":        expectedDatabaseName,
			"region":               awsRegion,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	dbInstanceID := terraform.Output(t, terraformOptions, "db_instance_id")

	address := aws.GetAddressOfRdsInstance(t, dbInstanceID, awsRegion)
	port := aws.GetPortOfRdsInstance(t, dbInstanceID, awsRegion)
	schemaExistsInRdsInstance := aws.GetWhetherSchemaExistsInRdsMySqlInstance(t, address, port, username, password, expectedDatabaseName)

	generalLogParameterValue := aws.GetParameterValueForParameterOfRdsInstance(t, "general_log", dbInstanceID, awsRegion)
	allowSuspiciousUdfsParameterValue := aws.GetParameterValueForParameterOfRdsInstance(t, "allow-suspicious-udfs", dbInstanceID, awsRegion)

	mariadbAuditPluginServerAuditEventsOptionValue := aws.GetOptionSettingForOfRdsInstance(t, "MARIADB_AUDIT_PLUGIN", "SERVER_AUDIT_EVENTS", dbInstanceID, awsRegion)

	assert.NotNil(t, address)
	assert.Equal(t, expectedPort, port)
	assert.True(t, schemaExistsInRdsInstance)
	assert.Equal(t, "0", generalLogParameterValue)
	assert.Equal(t, "", allowSuspiciousUdfsParameterValue)
	assert.Equal(t, "CONNECT", mariadbAuditPluginServerAuditEventsOptionValue)
}
