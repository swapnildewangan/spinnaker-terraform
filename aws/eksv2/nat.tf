resource "aws_eip" "eip_nat" {
  vpc = true

  tags = {
    Name = "demo-spinnaker-elastic-ip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.demo-spinnaker-public-us-east-1a.id

  tags = {
    Name = "demo-spinnaker-nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}
