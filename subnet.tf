resource "aws_subnet" "terraform_public_subnet_1" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.1.0/24"
	tags = {
		Name = "${var.subnet_name}-public-1"
		ManagedBy = "${var.managed_by}"
	}	
}

resource "aws_subnet" "terraform_private_subnet_1" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.2.0/24"
	tags = {
		Name = "${var.subnet_name}-private-1"
		ManagedBy = "${var.managed_by}"
	}
}