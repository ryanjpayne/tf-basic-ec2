/*
This module will create an EC2 Instance
This module relies on get-ami.tf and get-subnets.tf
Please complete parameters in locals block prior to use
Review EBS configuration and Tags prior to launch
*/

locals {
    name            = ""
    env             = "" # Enviroment tag and prefix to get-subnets.tf data sources
    az              = "" # a, b, etc
    tier            = "" # public or private
    instanceType    = "" # The type of instance to start (eg. m4.large)
    securityGroups  = [] # A list of security group IDs to associate with
    keyPair         = "" # Key name of the Key Pair to use for the instance
    instanceProfile = "" # IAM Instance Profile to launch the instance with
    rootVolumeSize  = "" # Root volume size in gb

    # Built from data source
    ami    = "data.aws_ami.ami.value" # This can be replaced with the AMI Id of your choice     
    subnet = "data.aws_ssm_parameter.${local.tier}-subnet-${local.az}" 
}

variable "env" {
  default = local.env
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  # For more information such as aadditional inputs see:
  # Module Info: https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
  # Source Code: https://github.com/terraform-aws-modules/terraform-aws-ec2-instance
  
  name                   = "${var.env}-${local.name}"
  ami                    = local.ami
  subnet_id              = local.subnet
  vpc_security_group_ids = local.securityGroups
  instance_type          = local.instanceType
  key_name               = local.keyPair
  iam_instance_profile   = local.instanceProfile

  /* Uncomment and update path to user-data script
  user_data = file("../bootstrap.ext")
  */

  # EBS Configuration
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = local.rootVolumeSize
    },
  ]
  
  /* Optional Additional Block Device
  ebs_block_device = [
    {
      device_name           = "/dev/xvdb"
      volume_type           = "gp2"
      volume_size           = "1000"
      encrypted             = true
      delete_on_termination = true
    }
  ]
  */
  
  tags = {
      Environment = local.env
      # Add tags here
   }
}
