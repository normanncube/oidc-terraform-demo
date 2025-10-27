data "aws_availability_zones" "available" {}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 0)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.project_name}-subnet-pub"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.this.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block = cidrsubnet(var.vpc_cidr, 8, 1)
  tags = {
    Name = "${var.project_name}-subnet-pvt"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.project_name}-rtb-pub"
  }
}
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

  