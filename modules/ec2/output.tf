output "image_id" {
  value = data.aws_ami.amazon_linux.id
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.my_subnet.id
}

output "ec2_instance_details" {
  value = [
    aws_instance.dev_test.arn,
    aws_instance.dev_test.instance_type,
    aws_instance.dev_test.private_ip,
    aws_instance.dev_test.security_groups
  ]
}
output "ec2_instance_tags" {
  value = aws_instance.dev_test.tags_all
}

output "ami_id" {
  value = aws_instance.dev_test.ami
}
