module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "app-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # enable_nat_gateway = true
  # enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


resource "aws_security_group" "terraform-app-security-group" {
	name = "terraform-app-security-group"
	description = "terraform-app-security-group"
	vpc_id = module.vpc.vpc_id

	tags = {
		Name = "terraform-app-security-group"
		Environment = "dev"
	}

	ingress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = [module.vpc.vpc_cidr_block, "115.99.14.198/32"]
	}

	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}


resource "aws_instance" "terraform-app-instance" {
	ami = "ami-02d26659fd82cf299"
	instance_type = "t2.micro"
	key_name = "terraform-key"

	subnet_id = module.vpc.public_subnets[0]
	associate_public_ip_address = true
	vpc_security_group_ids = [aws_security_group.terraform-app-security-group.id]

	tags = {
		Name = "terraform-app-instance"
		Environment = "dev"
	}
}