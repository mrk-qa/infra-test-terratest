variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "username" {
  description = "Master username of the DB"
  type        = string
  default     = "marcoqadb"
}

variable "password" {
  description = "Master password of the DB"
  type        = string
  default     = "12345678"
}

variable "database_name" {
  description = "Name of the database to be created"
  type        = string
  default     = "marcoqadb123"
}

variable "name" {
  description = "Name of the database"
  type        = string
  default     = "dbinfraterratest123"
}

variable "engine_name" {
  description = "Name of the database engine"
  type        = string
  default     = "mysql"
}

variable "family" {
  description = "Family of the database"
  type        = string
  default     = "mysql5.7"
}

variable "port" {
  description = "Port which the database should run on"
  type        = number
  default     = 3306
}

variable "major_engine_version" {
  description = "MAJOR.MINOR version of the DB engine"
  type        = string
  default     = "5.7"
}

variable "engine_version" {
  description = "Version of the database to be launched"
  default     = "5.7.44"
  type        = string
}

variable "allocated_storage" {
  description = "Disk space to be allocated to the DB instance"
  type        = number
  default     = 5
}

variable "license_model" {
  description = "License model of the DB instance"
  type        = string
  default     = "general-public-license"
}

variable "instance_class" {
  description = "Instance class to be used to run the database"
  type        = string
  default     = "db.t2.micro"
}

variable "tag_id_aws" {
  description = "Tag usado na AWS"
  type        = string
  default     = "terraform-with-terratest"
}