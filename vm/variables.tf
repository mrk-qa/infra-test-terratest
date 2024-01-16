variable "aws_key_pub" {
  description = "Chave pública para a VM na AWS"
  type        = string
}

variable "key_pair_name_aws" {
  description = "Nome da key pair usada na AWS"
  type        = string
  default     = "aws-key-infra-test-terratest"
}

variable "ami_vm" {
  description = "AMI to be used to run the VM instance"
  type = string
  default = "ami-0c7217cdde317cfec"
}

variable "instance_type_vm" {
  description = "Instance type to run the VM instance"
  type = string
  default = "t2.micro"
}

variable "tag_id_aws" {
  description = "Tag usado na AWS"
  type        = string
  default     = "terraform-with-terratest"
}