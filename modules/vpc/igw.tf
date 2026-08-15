resource "aws_internet_gateway" "mango_igw" {
  vpc_id = aws_vpc.mango_vpc.id
  tags = {
    "Name" = "mango_IGW"
  }

}