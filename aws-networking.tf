resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/22"
  tags = {
    Name = "portfolio"
  }
}

resource "aws_subnet" "public_sn" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "portfolio"
  }
}

resource "aws_internet_gateway" "igwt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "portfolio"
  }
}

#import {
##  to = aws_route_table_association.assoc
##  id = "subnet-0237860a7d956d3fd/rtb-01434b23e40f7dc53"
#}

resource "aws_route_table" "exit_to_igwt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igwt.id
  }

  tags = {
    Name = "portfolio"
  }
}

#resource "aws_route_table_association" "association" {
#  subnet_id      = aws_subnet.public_sn.id
#  route_table_id = aws_route_table.exit_to_igwt.id
#}
