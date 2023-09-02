locals {
  name   = "notbad-casestudy"
  region = "eu-east-1"
  vpc_cidr = "10.99.0.0/18"
  public_subnets   = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
  private_subnets  = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  tags = {
    Owner = "mhosseini"
  }
}