# AWS Infrastructure with Terraform

This project creates a complete AWS infrastructure using Terraform, including VPC, subnets, security groups, and EC2 instances.

## Architecture Overview

The infrastructure includes the following components:

1. **VPC** - Virtual Private Cloud with CIDR block 10.0.0.0/16
2. **Internet Gateway** - Provides internet access to the VPC
3. **Public Subnet** - 10.0.1.0/24 (for web servers)
4. **Private Subnet** - 10.0.2.0/24 (for database servers)
5. **Public Route Table** - Routes traffic to internet gateway
6. **Private Route Table** - Internal routing only
7. **Route Table Associations** - Links subnets to route tables
8. **Security Group** - Controls inbound/outbound traffic
9. **EC2 Public Instance** - Web server in public subnet
10. **EC2 Private Instance** - Database server in private subnet

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured
- SSH key pair named `terraform-key` in your AWS account
- AWS credentials configured

## Quick Start

### 1. Clone the repository

```bash
git clone <repository-url>
cd terraforms
```

### 2. Configure AWS credentials

```bash
aws configure
```

### 3. Create SSH key pair (if not exists)

```bash
# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa

# Import to AWS (replace with your key name)
aws ec2 import-key-pair --key-name "terraform-key" --public-key-material fileb://~/.ssh/id_rsa.pub
```

### 4. Initialize and apply Terraform

```bash
# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

### 5. Connect to instances

```bash
# Get public IP
terraform output terraform_ec2_public_ip

# SSH to public instance
ssh -i ~/.ssh/id_rsa ec2-user@<PUBLIC_IP>
```

## Configuration

### Variables

Key variables can be customized in `terraform.tfvars`:

```hcl
managed_by = "DevOps Team"
vpc_name = "terraform-vpc"
internet_gateway_name = "terraform-internet-gateway"
public_subnet_name = "terraform-public-subnet"
private_subnet_name = "terraform-private-subnet"
security_group_name = "terraform-security-group"
ec2_name = "terraform-ec2"
```

### Security Group Rules

- **SSH (22)**: Allowed from anywhere (0.0.0.0/0)
- **HTTP (80)**: Allowed from anywhere (0.0.0.0/0)
- **All Traffic**: Allowed within VPC CIDR and specific IP (115.99.14.198/32)

## Outputs

After successful deployment, you'll get:

- `terraform_ec2_public_ip` - Public IP of the web server
- `terraform_ec2_public_private_ip` - Private IP of the web server
- `terraform_ec2_public_id` - Instance ID of the web server
- `terraform_ec2_private_ip` - Private IP of the database server
- `terraform_ec2_private_id` - Instance ID of the database server

## Troubleshooting

### Common Issues

1. **No public IP assigned**

   - Ensure `associate_public_ip_address = true` is set
   - Verify the instance is in a public subnet

2. **SSH connection failed**

   - Check security group allows SSH (port 22)
   - Verify SSH key pair exists in AWS
   - Ensure correct username (ec2-user for Amazon Linux)

3. **Terraform state issues**
   - Never commit `.tfstate` files
   - Use remote state for team collaboration

### Useful Commands

```bash
# Check instance status
aws ec2 describe-instances --instance-ids $(terraform output -raw terraform_ec2_public_id)

# View security group rules
aws ec2 describe-security-groups --group-ids $(terraform output -raw security_group_id)

# Destroy infrastructure
terraform destroy
```

## File Structure

```
├── ec2.tf                 # EC2 instances configuration
├── internet-gate.tf       # Internet Gateway
├── providers.tf           # Terraform providers
├── route.tf              # Route tables and associations
├── security-group.tf     # Security group rules
├── subnet.tf             # Subnet configuration
├── variables.tf          # Variable definitions
├── vpc.tf                # VPC configuration
├── terraform.tfvars      # Variable values
└── .gitignore           # Git ignore rules
```

## Security Considerations

- **SSH Key Management**: Store private keys securely
- **Security Groups**: Review and restrict access as needed
- **Private Subnet**: Database instances have no direct internet access
- **State Files**: Never commit state files containing sensitive data

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `terraform plan`
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For issues and questions:

- Create an issue in the repository
- Check AWS documentation
- Review Terraform documentation

---

**Note**: Always review and test changes in a development environment before applying to production.
