resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.vpc_name}" // get the value from the variables.tf file
    ManagedBy = "${var.managed_by}"
  }
}

