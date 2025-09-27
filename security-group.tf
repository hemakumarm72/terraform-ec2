resource "aws_security_group" "terraform_security_group" {
	vpc_id = aws_vpc.terraform_vpc.id
	name = "${var.security_group_name}"
	tags = {
		Name = "${var.security_group_name}"
		ManagedBy = "${var.managed_by}"
	}

	ingress {
		description = "Allow all inbound traffic with specific ip and vpc cidr block"
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = [aws_vpc.terraform_vpc.cidr_block, "115.99.14.198/32"]
	}
	ingress {
		description = "Allow HTTP traffic"		
		from_port = 80
		to_port = 80
		protocol = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}
		ingress {
		description = "Allow SSH PORT"		
		from_port = 22
		to_port = 22
		protocol = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {		
		description = "Allow all outbound traffic"
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
	}
}