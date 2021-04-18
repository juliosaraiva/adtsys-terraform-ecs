resource "aws_subnet" "public_a" {
  cidr_block              = var.cidr_block_public_a
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.avail_zone}a"

  tags = merge(
    var.common_tags,
    tomap({ "Name" = "${var.prefix}-public-a" })
  )
}

resource "aws_route_table" "public_a" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    tomap({ "Name" = "${var.prefix}-public-a" })
  )
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_a.id
}

resource "aws_route" "public_internet_access_a" {
  route_table_id         = aws_route_table.public_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_eip" "public_a" {
  vpc = true

  tags = merge(
    var.common_tags,
    tomap({ "Name" = "${var.prefix}-public-a" })
  )
}

resource "aws_nat_gateway" "public_a" {
  allocation_id = aws_eip.public_a.id
  subnet_id     = aws_subnet.public_a.id

  tags = merge(
    var.common_tags,
    tomap({ "Name" = "${var.prefix}-public-a" })
  )
}
############
# Subnet B #
############
resource "aws_subnet" "public_b" {
  cidr_block        = var.cidr_block_public_b
  vpc_id            = aws_vpc.main.id
  availability_zone = "${var.avail_zone}b"

  tags = merge(
    var.common_tags,
    tomap({ "Name" = "${var.prefix}-public-b" })
  )
}

resource "aws_route_table" "public_b" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    tomap({ "Name" = "${var.prefix}-public-b" })
  )
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_b.id
}

resource "aws_route" "public_internet_access_b" {
  route_table_id         = aws_route_table.public_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_eip" "public_b" {
  vpc = true

  tags = merge(
    var.common_tags,
    tomap({ "Name" = "${var.prefix}-public-b" })
  )
}

resource "aws_nat_gateway" "public_b" {
  allocation_id = aws_eip.public_b.id
  subnet_id     = aws_subnet.public_b.id

  tags = merge(
    var.common_tags,
    tomap({ "Name" = "${var.prefix}-public-b" })
  )
}
