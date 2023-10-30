resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.name}-Prod-vpc"
  }
}

resource "aws_subnet" "public1" {
  vpc_id                 = aws_vpc.main.id
  cidr_block             = var.public_subnet1_cidr_blocks
  availability_zone      = var.availability_zones[0]
  tags = {
    Name = "${var.name}-public-subnet1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                 = aws_vpc.main.id
  cidr_block             = var.public_subnet2_cidr_blocks
  availability_zone      = var.availability_zones[1]
  tags = {
    Name = "${var.name}-public-subnet2"
  }
}

resource "aws_subnet" "private1" {
  count             = length(var.private_subnet1_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet1_cidr_blocks[count.index]
  availability_zone = var.availability_zones[0]
  tags = {
    Name = "${var.name}-App-subnet1-${count.index}"
  }
}

resource "aws_subnet" "private2" {
  count             = length(var.private_subnet2_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet2_cidr_blocks[count.index]
  availability_zone = var.availability_zones[1]
  tags = {
    Name = "${var.name}-App-subnet2-${count.index}"
  }
}

resource "aws_subnet" "rds1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.rds_private_subnet1_cidr_blocks
  availability_zone = var.availability_zones[0]
  tags = {
    Name = "${var.name}-rds-subnet1"
  }
}

resource "aws_subnet" "rds2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.rds_private_subnet2_cidr_blocks
  availability_zone = var.availability_zones[1]
  tags = {
    Name = "${var.name}-rds-subnet2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_route_table" "public_route_table1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.name}-public-route-table1"
  }
}

resource "aws_route_table" "public_route_table2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.name}-public-route-table2"
  }
}

resource "aws_route_table_association" "public_rt_association1" {

  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_route_table1.id
}

resource "aws_route_table_association" "public_rt_association2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_route_table2.id
}

resource "aws_eip" "eip1" {
  domain = "vpc"
  depends_on  = [aws_internet_gateway.gw]
}

resource "aws_eip" "eip2" {
  domain = "vpc"
  depends_on  = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat1" {
  allocation_id     = aws_eip.eip1.id
  subnet_id         = aws_subnet.public1.id
  depends_on        = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat2" {
  allocation_id     = aws_eip.eip2.id
  subnet_id         = aws_subnet.public2.id
  depends_on        = [aws_internet_gateway.gw]
}

resource "aws_route_table" "private_route_table1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }
  tags = {
    Name = "${var.name}-private-route-table1"
  }
}

resource "aws_route_table" "private_route_table2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat2.id
  }
  tags = {
    Name = "${var.name}-private-route-table2"
  }
}

resource "aws_route_table_association" "private_rt_association1" {
  count          = length(aws_subnet.private1)
  subnet_id      = aws_subnet.private1[count.index].id
  route_table_id = aws_route_table.private_route_table1.id
}

resource "aws_route_table_association" "private_rt_association2" {
  count          = length(aws_subnet.private2)
  subnet_id      = aws_subnet.private2[count.index].id
  route_table_id = aws_route_table.private_route_table2.id
}

resource "aws_route_table" "rds_route_table1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }
  tags = {
    Name = "${var.name}-rds-route-table1"
  }
}

resource "aws_route_table" "rds_route_table2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat2.id
  }
  tags = {
    Name = "${var.name}-rds-route-table2"
  }
}

resource "aws_route_table_association" "rds_rt_association1" {
  subnet_id      = aws_subnet.rds1.id
  route_table_id = aws_route_table.rds_route_table1.id
}

resource "aws_route_table_association" "rds_rt_association2" {
  subnet_id      = aws_subnet.rds2.id
  route_table_id = aws_route_table.rds_route_table2.id
}
