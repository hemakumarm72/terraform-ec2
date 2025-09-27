resource "aws_route_table" "terraform_public_route_table" {
	vpc_id = aws_vpc.terraform_vpc.id
	// attrache the internet gateway
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.terraform_internet_gateway.id
	}
	tags = {
		Name = "${var.subnet_name}-public-rt"
		ManagedBy = "${var.managed_by}"
	}
}

resource "aws_route_table" "terraform_private_route_table" {
	vpc_id = aws_vpc.terraform_vpc.id
	// private network no need internet, only used db or other services.


	tags = {
		Name = "${var.subnet_name}-private-rt"
		ManagedBy = "${var.managed_by}"
	}
}		

// assication the public route table with the public subnet
resource "aws_route_table_association" "terraform_public_route_table_association" {
	subnet_id = aws_subnet.terraform_public_subnet_1.id
	route_table_id = aws_route_table.terraform_public_route_table.id
}

// assication the private route table with the private subnet
resource "aws_route_table_association" "terraform_private_route_table_association" {
	subnet_id = aws_subnet.terraform_private_subnet_1.id
	route_table_id = aws_route_table.terraform_private_route_table.id
}


