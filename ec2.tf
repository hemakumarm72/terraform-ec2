resource "aws_instance" "terraform_ec2_public" {
	ami = "ami-02d26659fd82cf299"
	instance_type = "t2.micro"
  key_name = "terraform-key"
	associate_public_ip_address = true
	tags = {
		Name = "${var.ec2_name}-public"
		ManagedBy = "${var.managed_by}"
	}
	vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
	subnet_id = aws_subnet.terraform_public_subnet_1.id
}

resource "aws_instance" "terraform_ec2_private" {
	ami = "ami-02d26659fd82cf299"
	instance_type = "t2.micro"
  key_name = "terraform-key"
	tags = {
		Name = "${var.ec2_name}-private"
		ManagedBy = "${var.managed_by}"
	}
	vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
	subnet_id = aws_subnet.terraform_private_subnet_1.id
}

// terraform public ec2 output
output "terraform_ec2_public_ip" {
	value = aws_instance.terraform_ec2_public.public_ip
}

output "terraform_ec2_public_private_ip" {
	value = aws_instance.terraform_ec2_public.private_ip
}


output "terraform_ec2_public_id" {
	value = aws_instance.terraform_ec2_public.id
}


// terraform private ec2 output
output "terraform_ec2_private_ip" {
	value = aws_instance.terraform_ec2_private.private_ip
}

output "terraform_ec2_private_id" {
	value = aws_instance.terraform_ec2_private.id
}





