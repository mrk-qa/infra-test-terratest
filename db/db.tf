resource "aws_db_instance" "db_instance" {
  identifier             = var.name
  engine                 = var.engine_name
  engine_version         = var.engine_version
  port                   = var.port
  db_name                = var.database_name
  username               = var.username
  password               = var.password
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  skip_final_snapshot    = true
  license_model          = var.license_model
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.db_instance.id]
  publicly_accessible    = true
  parameter_group_name   = aws_db_parameter_group.db_parameter.id
  option_group_name      = aws_db_option_group.db_option.id

  tags = {
    Name = var.tag_id_aws
  }
}

resource "aws_db_option_group" "db_option" {
  name                 = var.name
  engine_name          = var.engine_name
  major_engine_version = var.major_engine_version

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"

    option_settings {
      name  = "SERVER_AUDIT_EVENTS"
      value = "CONNECT"
    }
  }

  tags = {
    Name = var.tag_id_aws
  }
}

resource "aws_db_parameter_group" "db_parameter" {
  name   = var.name
  family = var.family

  parameter {
    name  = "general_log"
    value = "0"
  }

  tags = {
    Name = var.tag_id_aws
  }
}