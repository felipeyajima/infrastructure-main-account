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


resource "aws_route_table" "exit_to_igtw" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igtw.id}"
  }

  tags = {
    Name = "portfolio"
  }
}

