resource "aws_vpc" "mango_vpc" {
  cidr_block = var.vpc_cidr

  tags = merge(
    local.common_name,
    {
      "Env" = "k8s"
    }
  )
}

