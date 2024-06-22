resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.TerraformVPC.id

  tags = {
    Name = "main"
  }
}

resource "aws_eip" "nat_eip" {
  instance = null
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NATGateway"
  }
}