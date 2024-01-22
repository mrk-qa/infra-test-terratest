package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ec2"
	"github.com/gruntwork-io/terratest/modules/aws"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/stretchr/testify/assert"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformAwsInstance(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../resources/vm/",
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	publicIp := terraform.Output(t, terraformOptions, "public_ip")

	url := fmt.Sprintf("http://%s:80", publicIp)
	http_helper.HttpGetWithRetry(t, url, nil, 200, "Hello, Marco!", 30, 5*time.Second)

	filters := map[string][]string{
		"tag:Name": {"terraform-with-terratest"},
	}

	instanceIDs := aws.GetEc2InstanceIdsByFilters(t, "us-east-1", filters)

	assert.NotEmpty(t, instanceIDs, "Nenhuma instância EC2 encontrada com os filtros fornecidos")

	instanceID := instanceIDs[0]

	sess := session.Must(session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
	}))
	ec2Client := ec2.New(sess)

	describeInstancesInput := &ec2.DescribeInstancesInput{
		InstanceIds: []*string{&instanceID},
	}

	describeInstancesOutput, err := ec2Client.DescribeInstances(describeInstancesInput)
	assert.NoError(t, err, "Erro ao descrever instância EC2")

	// Validações dos atributos da EC2
	architecture := describeInstancesOutput.Reservations[0].Instances[0].Architecture
	assert.Equal(t, "x86_64", *architecture, "A instância EC2 não está usando a arquitetura 64 bits (x86)")

	platform := describeInstancesOutput.Reservations[0].Instances[0].Platform
	if platform != nil {
		assert.True(t, strings.Contains(*platform, "ubuntu"), "A instância EC2 não está usando o sistema operacional Ubuntu")
	}

	instanceType := describeInstancesOutput.Reservations[0].Instances[0].InstanceType
	assert.Equal(t, "t2.micro", *instanceType, "O tipo da instância EC2 não está compatível")

	cpuOptionsThreadsPerCore := describeInstancesOutput.Reservations[0].Instances[0].CpuOptions.ThreadsPerCore
	assert.Equal(t, int64(1), *cpuOptionsThreadsPerCore, "A instância EC2 tem números de Threads Por Core diferente")

	cpuOptionsCoreCount := describeInstancesOutput.Reservations[0].Instances[0].CpuOptions.CoreCount
	assert.Equal(t, int64(1), *cpuOptionsCoreCount, "A instância EC2 tem números de Core diferente")

	RootDeviceType := describeInstancesOutput.Reservations[0].Instances[0].RootDeviceType
	assert.Equal(t, "ebs", *RootDeviceType, "O armazenamento da instância EC2 não é compatível")

	Hypervisor := describeInstancesOutput.Reservations[0].Instances[0].Hypervisor
	assert.Equal(t, "xen", *Hypervisor, "O hypervisor da instância EC2 não é compatível")

	VirtualizationType := describeInstancesOutput.Reservations[0].Instances[0].VirtualizationType
	assert.Equal(t, "hvm", *VirtualizationType, "A virtualização da instância EC2 não é compatível")

	SetEnaSupport := describeInstancesOutput.Reservations[0].Instances[0].EnaSupport
	assert.Equal(t, true, *SetEnaSupport, "A instância EC2 não tem suporte a ENA ativado")

	AvailabilityZone := describeInstancesOutput.Reservations[0].Instances[0].Placement.AvailabilityZone
	assert.Equal(t, "us-east-1f", *AvailabilityZone, "A AZ da instância EC2 não está correta")
}
