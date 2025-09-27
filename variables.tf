variable "vpc_name" {
  description = "The name of the VPC"
  type = string
  default = "terraform_vpc"
	# validation {
	# 	condition = length(var.vpc_name) > 0
	# 	error_message = "VPC name must be provided"
	# }
}

variable "internet_gateway_name" {
  description = "The name of the Internet Gateway"
  type = string
  default = "terraform-internet-gateway"
}


variable "managed_by" {
  description = "The name of the Managed By"
  type = string
  default = "DevOps Team"
}

variable "subnet_name" {
  description = "The name of the Subnet"
  type = string
  default = "terraform-subnet"
}



variable "security_group_name" {
  description = "The name of the Security Group"
  type = string
  default = "terraform-security-group"
}

variable "ec2_name" {
  description = "The name of the EC2"
  type = string
  default = "terraform-ec2"
}