resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.mango_vpc.id
  count                   = length(var.public_subnet)
  cidr_block              = var.public_subnet[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.az_list.names[count.index]

  tags = merge(
    local.common_name,
    {
      Name = "public-subnet-${data.aws_availability_zones.az_list.names[count.index]}"
    }
  )
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.mango_vpc.id
  count             = length(var.private_subnet)
  cidr_block        = var.private_subnet[count.index]
  availability_zone = data.aws_availability_zones.az_list.names[count.index]

  tags = merge(
    local.common_name,
    {
      Name = "private-subnet-${data.aws_availability_zones.az_list.names[count.index]}"
    }
  )
}

resource "aws_route_table" "mango_publicRT" {
  vpc_id = aws_vpc.mango_vpc.id

  tags = {
    Name = "mango_PublicRT"
  }
}

resource "aws_route_table" "mango_privateRT" {
  vpc_id = aws_vpc.mango_vpc.id

  tags = {
    Name = "mango_PrivateRT"
  }
}

resource "aws_route_table_association" "mango_publicRT_association" {
  route_table_id = aws_route_table.mango_publicRT.id
  count          = length(var.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id

}

resource "aws_route_table_association" "mango_privateRT_association" {
  route_table_id = aws_route_table.mango_privateRT.id
  count          = length(var.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
}

resource "aws_route" "public_route_internet" {
  route_table_id         = aws_route_table.mango_publicRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mango_igw.id
  depends_on             = [aws_route_table.mango_privateRT, aws_route_table_association.mango_publicRT_association]
}