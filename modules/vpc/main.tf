# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  # Enable DNS for internal resources
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

#PART 2 - create private network 

#Private Subnet for one AZ
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc_name}-private-subnet"
  }
} 

# CHANGE bc error need 2 az

# resource "aws_subnet" "private_a" {
#   vpc_id            = aws_vpc.private_a.id
#   cidr_block        = var.private_subnet_cidrs["us-east-1a"]
#   availability_zone = "us-east-1a"
#   tags = { Name = "private-subnet-a" }
# }

# resource "aws_subnet" "private_b" {
#   vpc_id            = aws_vpc.private_b.id
#   cidr_block        = var.private_subnet_cidrs["us-east-1b"]
#   availability_zone = "us-east-1b"
#   tags = { Name = "private-subnet-b" }
# }



# Create Public Subnet inside VPC.
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet"
  }
}

# Create Internet Gateway for Internet access
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Create public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Associate route table with public subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
