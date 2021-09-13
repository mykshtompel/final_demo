# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.aws_dns
  enable_dns_hostnames = var.aws_dns

  tags = {
    Name = "${var.app}-${var.env}-vpc"
  }
}

# Public subnets
resource "aws_subnet" "public_subnet" {
  count      = local.number_public_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index + 1)

  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.app}-${var.env}-public_subnet_${count.index + 1}_${substr(local.azs[count.index], -2, 2)}"
  }
}

# Private subnets
resource "aws_subnet" "private_subnet" {
  count      = local.number_private_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index + 101)

  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.app}-${var.env}-private_subnet_${count.index + 1}_${substr(local.azs[count.index], -2, 2)}"
  }
}

# Internet Gateway for public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.app}-${var.env}-igw"
  }
}

# Elastic IP for private subnets
resource "aws_eip" "elastic_ip_for_nat_gw" {
  count      = local.number_private_subnets
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.app}-${var.env}-eip_${count.index + 1}_${substr(local.azs[count.index], -2, 2)}"
  }
}

# NAT Gateway for private subnets
resource "aws_nat_gateway" "nat_gw" {
  count         = local.number_private_subnets
  allocation_id = aws_eip.elastic_ip_for_nat_gw[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  depends_on    = [aws_eip.elastic_ip_for_nat_gw]

  tags = {
    Name = "${var.app}-${var.env}-nat_gw_${count.index + 1}_${substr(local.azs[count.index], -2, 2)}"
  }
}

# Route table for the public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.app}-${var.env}-public_route_table"
  }
}

# Route table for the private subnets
resource "aws_route_table" "private_route_table" {
  count  = local.number_private_subnets
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.app}-${var.env}-private_route_table_${count.index + 1}"
  }
}

# Route the public subnets traffic through the internet gateway
resource "aws_route" "public_igw-route" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"

}

# Route the private subnets traffic through the NAT gateway
resource "aws_route" "nat_gw_route" {
  count                  = local.number_private_subnets
  route_table_id         = aws_route_table.private_route_table[count.index].id
  nat_gateway_id         = aws_nat_gateway.nat_gw[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}

# Associate the route tables to the public subnets
resource "aws_route_table_association" "public_route_association" {
  count          = local.number_public_subnets
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

resource "aws_route_table_association" "private_route_association" {
  count          = local.number_private_subnets
  route_table_id = aws_route_table.private_route_table[count.index].id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}
