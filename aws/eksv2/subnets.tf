## Creating 3 private subnets ##
## 1. demo-spinnaker-private-us-east-1a, in us-east-1a AZ ##
## 2. demo-spinnaker-private-us-east-1b, in us-east-1b AZ ##
## 3. demo-spinnaker-private-us-east-1c, in us-east-1c AZ ##

resource "aws_subnet" "demo-spinnaker-private-us-east-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.demo-spinnaker-private-us-east-1a-cidr
  availability_zone = "us-east-1a"

  tags = {
    "Name"                            = "private-us-east-1a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "demo-spinnaker-private-us-east-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.demo-spinnaker-private-us-east-1b-cidr
  availability_zone = "us-east-1b"

  tags = {
    "Name"                            = "private-us-east-1b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "demo-spinnaker-private-us-east-1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.demo-spinnaker-private-us-east-1c-cidr
  availability_zone = "us-east-1c"

  tags = {
    "Name"                            = "private-us-east-1c"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

## Creating 3 Public subnets ##
## 1. demo-spinnaker-public-us-east-1a, in us-east-1a AZ ##
## 2. demo-spinnaker-public-us-east-1b, in us-east-1b AZ ##
## 3. demo-spinnaker-public-us-east-1c, in us-east-1c AZ ##

resource "aws_subnet" "demo-spinnaker-public-us-east-1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.demo-spinnaker-public-us-east-1a-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "demo-spinnaker-public-us-east-1a"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

resource "aws_subnet" "demo-spinnaker-public-us-east-1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.demo-spinnaker-public-us-east-1b-cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-us-east-1b"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

resource "aws_subnet" "demo-spinnaker-public-us-east-1c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.demo-spinnaker-public-us-east-1c-cidr
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "demo-spinnaker-public-us-east-1c"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}
