variable "db_username" {
  description = "The username for the RDS database"
  type        = string
  default     = "postgresadmin"
}

variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "appdb"
}