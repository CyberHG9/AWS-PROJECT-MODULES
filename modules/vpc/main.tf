#Create VPC

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  #enable DNS internal resources
  enable_dns_hostnames = true
  enable_dns_support = true

tags = {
    Name = var.vpc_name
}

# Create Subnet públic inside VPC
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.az

  tags = {
    Name = "${var.vpc_name}-public-subnet"
  }
}

# Create Internet Gateway access to Internet
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Create table route públic
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Asocciate table route with Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

}