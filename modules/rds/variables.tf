variable "db_identifier" { type = string }
variable "db_engine" { type = string }
variable "db_engine_version" { type = string }
variable "db_instance_class" { type = string }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "sg_id" { type = string }
#variable "private_subnet_id" { type = string }
# variable "private_subnet_ids" {
#   type = list(string)
# }

variable "private_subnet_ids" {
  description = "List of private subnet IDs for DB subnet group (must contain subnets in at least 2 AZs)"
  type        = list(string)
}

# # Optional 
# variable "multi_az" {
#   description = "Enable Multi-AZ RDS"
#   type        = bool
#   default     = true
# }