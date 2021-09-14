# Get AMI for use with EC2 Module

data "aws_ami" "ami" {
  most_recent = true
  owners      = [""] # Valid values: accountId, "self" (the current account), or an AWS owner alias (e.g. amazon, aws-marketplace, microsoft)

  filter {
    name   = "name"
    values = [""]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
