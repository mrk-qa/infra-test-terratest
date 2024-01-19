variable "ami_vm" {
  description = "AMI to be used to run the VM instance"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type_vm" {
  description = "Instance type to run the VM instance"
  type        = string
  default     = "t2.micro"
}

variable "tag_id_aws" {
  description = "Tag usado na AWS"
  type        = string
  default     = "terraform-with-terratest"
}

variable "application_name" {
  default = "ec2-attributes-test"
}