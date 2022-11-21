resource "aws_vpc" "AWS_VPC" {
  cidr_block           = var.vpc_config["cidr_block"]
  enable_dns_support   = var.vpc_config["enable_dns_support"]
  enable_dns_hostnames = var.vpc_config["enable_dns_hostnames"]
  instance_tenancy     = var.vpc_config["instance_tenancy"]
  tags = {
    Name               = "MBekas-portfolio-VPC"
    Owner       = var.tags["Owner"]
    expiration_date = var.tags["expiration_date"]
    bootcamp    = var.tags["bootcamp"]
  }
}

resource "aws_subnet" "AWS_SUBNETS" {
  count = var.subnet_count
  vpc_id                  = aws_vpc.AWS_VPC.id
  cidr_block              = var.subnets[count.index]["cidr"]
  availability_zone       = var.subnets[count.index]["az"]
  map_public_ip_on_launch = var.subnets[count.index]["public_ip"]
  tags = {
    Name                  = "MBekas-portfolio-SUBNET"
    Owner       = var.tags["Owner"]
    expiration_date = var.tags["expiration_date"]
    bootcamp    = var.tags["bootcamp"]
  }
}
