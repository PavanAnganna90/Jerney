output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_ids" {
  value = [
    aws_subnet.my_subnet_01.id,
    aws_subnet.my_subnet_02.id,
    aws_subnet.my_subnet_private_1.id,
  ]
}

output "instance_id" {
  value = aws_instance.blog_ec2.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.my_igw.id
}
