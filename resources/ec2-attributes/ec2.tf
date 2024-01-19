resource "aws_instance" "vm" {
  ami                         = var.ami_vm
  instance_type               = var.instance_type_vm
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id_aws_full
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id_aws_full]
  associate_public_ip_address = true

  tags = {
    Name = var.application_name
  }
}