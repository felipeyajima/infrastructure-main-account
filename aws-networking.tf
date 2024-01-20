resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/22"
}

resource "aws_subnet" "public_sn" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igwt" {
  vpc_id = aws_vpc.main.id
}

