resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = false

  tags = {
    Name = "my-vpc-1"
  }
}

resource "aws_subnet" "my_subnet_01" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "my-subnet-01"
  }
}

resource "aws_subnet" "my_subnet_02" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "my-subnet-02"
  }
}

resource "aws_subnet" "my_subnet_private_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "my-subnet-private-1"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-internet-gateway"
  }
}

resource "aws_route_table" "my_route_table_main" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "my_route_table_public" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-route-table-01"
  }
}

resource "aws_route_table" "my_route_table_private" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-route-table-private"
  }
}

resource "aws_route_table_association" "public_subnet_01" {
  subnet_id      = aws_subnet.my_subnet_01.id
  route_table_id = aws_route_table.my_route_table_public.id
}

resource "aws_route_table_association" "public_subnet_02" {
  subnet_id      = aws_subnet.my_subnet_02.id
  route_table_id = aws_route_table.my_route_table_public.id
}

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.my_subnet_private_1.id
  route_table_id = aws_route_table.my_route_table_private.id
}

resource "aws_instance" "blog_ec2" {
  ami                         = "ami-091138d0f0d41ff90"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.my_subnet_01.id
  private_ip                  = "10.0.0.35"
  key_name                    = "abhishek-devsecops-ec2"
  vpc_security_group_ids      = ["sg-09f3c55526065d0f1"]
  associate_public_ip_address = false

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    delete_on_termination = true
    iops                  = 3000
    throughput            = 125
  }

  tags = {
    Name = "BLOG-EC2-1"
  }
}
