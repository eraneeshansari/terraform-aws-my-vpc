variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"

}

variable "name" {
  type    = string
  default = "mango-vpc"
}

variable "environment" {
  type    = string
  default = "k8s"
}


variable "public_subnet" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

