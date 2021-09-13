# Module outputs
output "aws_region_name" {
  value       = data.aws_region.current.name
  description = "The name of current AWS region."
}

output "alb_hostname" {
  value       = aws_alb.alb.dns_name
  description = "The DNS name of Application Load Balancer (ALB)."
}

output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC."
}

output "public_subnet_ids" {
  value       = aws_subnet.public_subnet.*.id
  description = "The IDs of the public subnets."
}

output "private_subnet_ids" {
  value       = aws_subnet.private_subnet.*.id
  description = "The IDs of the private subnets."
}

output "public_subnet_cidrs" {
  value       = aws_subnet.public_subnet.*.cidr_block
  description = "The CIDR blocks of the public subnets."
}

output "private_subnet_cidrs" {
  value       = aws_subnet.private_subnet.*.cidr_block
  description = "The CIDR blocks of the private subnets."
}

output "igw_id" {
  value       = aws_internet_gateway.igw.id
  description = "The ID of the internet gateway."
}

output "public_route_table_id" {
  value       = aws_route_table.public_route_table.id
  description = "The ID of the public route table."
}

output "elastic_ip_for_nat_gw_ids" {
  value       = aws_eip.elastic_ip_for_nat_gw.*.id
  description = "The IDs of the elastic IP for NAT gateways."
}

output "nat_gw_ids" {
  value       = aws_nat_gateway.nat_gw.*.id
  description = "The IDs of the NAT gateways."
}

output "nat_gw_public_ips" {
  value       = aws_nat_gateway.nat_gw.*.public_ip
  description = "The public IP addresses of the NAT gateways."
}

output "private_route_table_ids" {
  value       = aws_route_table.private_route_table.*.id
  description = "The IDs of the private route tables."
}
