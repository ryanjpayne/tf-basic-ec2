/*
If configuring EC2 layers separate from existing VPC configuration
(see ryanjpayne/tf-basic-vpc/vpc-put-parameters.tf)
*/

data "aws_ssm_parameter" "private-subnet-a" {
name = "${var.env}-private-subnet-a"
}

data "aws_ssm_parameter" "private-subnet-b" {
name = "${var.env}-private-subnet-b"
}

data "aws_ssm_parameter" "private-subnet-c" {
name = "${var.env}-private-subnet-c"
}

data "aws_ssm_parameter" "public-subnet-a" {
name = "${var.env}-public-subnet-a"
}

data "aws_ssm_parameter" "public-subnet-b" {
name = "${var.env}-public-subnet-b"
}

data "aws_ssm_parameter" "public-subnet-c" {
name = "${var.env}-public-subnet-c"
}
