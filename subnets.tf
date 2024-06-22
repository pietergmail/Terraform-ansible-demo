resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.TerraformVPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.TerraformVPC.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet2"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.TerraformVPC.id
  cidr_block              = "10.0.3.0/24" 
  availability_zone       = "us-east-1c"

  tags = {
    Name = "PrivateSubnet"
  }
}