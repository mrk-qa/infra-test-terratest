variable "aws_key_pub" {
  description = "Chave pública para a VM na AWS"
  type        = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCk93XNluP3vFBjfoK/CjtRnW+SLqFe+7DHN+fGnoUbyNdWViQBJ+Vl3fgL/1nD6WihfP8cRUucZ3n9U6ih2f4n6uIHS7BlI2iVDrdfj5W2HG3Jm2gZSVgSazcqJ36VOWXRQAeBIiLcdCt5m5W9drEL69EkFKpYF1cyZeaVD1/ogbero+VERfEZ8H8CC4jsV0CraN4Cw2vunqqV2t0rdyCqrSQUgArgoqd6hCCmcTeWQOXQzLolTnEtJ/R33JnDqC5IXt5LBvmmjILn0jgswFGWkat2LgM0Ts4Fcdr1UnAhvCzPKtbKB2n4R5ettXQ9f1DubfUubyDbviKr6V5/geBx marco-qa@MRK"
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