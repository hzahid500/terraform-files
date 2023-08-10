terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.1"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_new_vpc" {
  cidr_block           = "10.0.0.0/20"
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "my_new_vpc"
  }
}

resource "aws_subnet" "my_new_vpc_subnet" {
  vpc_id     = aws_vpc.my_new_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my_new_vpc_subnet"
  }

}

resource "aws_subnet" "my_new_vpc_subnet_02" {
  vpc_id     = aws_vpc.my_new_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "my_new_vpc_subnet_02"
  }
}

resource "aws_instance" "my_new_instance" {
  ami           = "ami-06b09bfacae1453cb"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_new_vpc_subnet.id

  tags = {
    Name = "my_new_instance"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_new_vpc.id
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_new_vpc.id

  route {
    cidr_block = "0.0.0.0/10"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my_new_vpc"
    Name = "my_new_vpc_subnet"
    Name = "my_new_vpc_subnet_02"
    Name = "my_new_instance"
    Name = "my_igw"
    Name = "my_route_table"
  }
}
