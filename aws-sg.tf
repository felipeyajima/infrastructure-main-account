resource "aws_security_group" "allow_internet_turnon" {
  name        = "allow_internet_turnon"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_internet_turnon.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_internet" {
  security_group_id = aws_security_group.allow_internet_turnon.id

  cidr_ipv4   = "0.0.0.0/8"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}
