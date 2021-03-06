/* Default security group */
resource "aws_security_group" "default" {
  name = "POC-SG"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC and "
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["${var.mgt_subnets}"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "POC-default-vpc"
  }
}
