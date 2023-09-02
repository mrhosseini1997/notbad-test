# VPC Config
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2"

  name = local.name
  cidr = local.vpc_cidr

  azs      = local.azs
  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  enable_dns_hostnames         = true
  enable_nat_gateway  = true
  single_nat_gateway  = true
  reuse_nat_ips       = true
  external_nat_ip_ids = aws_eip.eip_nat.*.id

}

#Elastic IP for NAT Gateway
resource "aws_eip" "eip_nat" {
  vpc = true
}

###
resource "aws_security_group" "public" {
  name        = "Allow public HTTP/HTTPS ALB"
  description = "Public internet access"
  vpc_id      = module.vpc.vpc_id

}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 8089
  to_port           = 8089
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}

resource "aws_security_group" "ec2_ecs_instance" {
  name        = "Allow internal VPC traffic"
  description = "Allow internal VPC traffic"
  vpc_id      = module.vpc.vpc_id

}

resource "aws_security_group_rule" "allow_internal_VPC_traffic" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.99.0.0/18"]
  security_group_id = aws_security_group.ec2_ecs_instance.id
}

resource "aws_security_group_rule" "public_out_ec2" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.ec2_ecs_instance.id
}