# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

# Internet Gateway 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = { Name = "${var.vpc_name}-igw" }
}

# public subnets (una x AZ)
resource "aws_subnet" "public" {
  for_each = { for idx, az in var.azs : idx => az }

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidrs[each.key]
  availability_zone       = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-${each.value}"
  }
}

# private subnets (una x AZ)
resource "aws_subnet" "private" {
  for_each = { for idx, az in var.azs : idx => az }

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidrs[each.key]
  availability_zone       = each.value
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc_name}-private-${each.value}"
  }
}

# Public route table (route to IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = { Name = "${var.vpc_name}-public-rt" }
}

# Associate public route table with public subnets
resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Elastic IP for NAT gateway (single NAT for DEV)
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.gw]
  tags = { Name = "${var.vpc_name}-nat-eip" }
}

# NAT Gateway in the first public subnet (sufficient for DEV)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = element(values(aws_subnet.public)[*].id, 0) # tomamos la primera public subnet en orden y coloca el nat ahi
  tags = { Name = "${var.vpc_name}-nat" }
  depends_on = [aws_internet_gateway.gw]
}

# Private route table -> route to NAT
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = { Name = "${var.vpc_name}-private-rt" }
}

# Associate private route table with all private subnets
resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
