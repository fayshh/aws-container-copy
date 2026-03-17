resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "project-vpc"
  }
}

# PUBLIC SUBNETS

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "project-subnet-public1-us-east-1a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "project-subnet-public2-us-east-1b"
  }
}

# PRIVATE SUBNETS

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.128.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "project-subnet-private1-us-east-1a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.144.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "project-subnet-private2-us-east-1b"
  }
}

# INTERNET GATEWAY

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "project-igw"
  }
}

# ROUTE TABLES

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "project-rtb-public"
  }
}

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "project-rtb-private1-us-east-1a"
  }
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "project-rtb-private2-us-east-1b"
  }
}

# ROUTE TABLE ASSOCIATIONS

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_b.id
}

# SECURITY GROUP

resource "aws_security_group" "app_server" {
  name        = "xpix-app-server"
  description = "allow XPix app server connections"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.app_server.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "yer"
}

# IMPORTS

import {
  to = aws_vpc.main
  id = "vpc-0a8790330e16fef52"
}

import {
  to = aws_subnet.public_a
  id = "subnet-018474c856ebff3ce"
}

import {
  to = aws_subnet.public_b
  id = "subnet-0b7836d4fff246c8e"
}

import {
  to = aws_subnet.private_a
  id = "subnet-05499aa9565d8e573"
}

import {
  to = aws_subnet.private_b
  id = "subnet-030123e9cebb3a459"
}

import {
  to = aws_internet_gateway.main
  id = "igw-089dc989eb9dcb807"
}

import {
  to = aws_route_table.public
  id = "rtb-0ebae4af20aabf5e1"
}

import {
  to = aws_route_table.private_a
  id = "rtb-04259fa091fd36145"
}

import {
  to = aws_route_table.private_b
  id = "rtb-076d0fd4736a237d4"
}

import {
  to = aws_route_table_association.public_a
  id = "subnet-018474c856ebff3ce/rtb-0ebae4af20aabf5e1"
}

import {
  to = aws_route_table_association.public_b
  id = "subnet-0b7836d4fff246c8e/rtb-0ebae4af20aabf5e1"
}

import {
  to = aws_route_table_association.private_a
  id = "subnet-05499aa9565d8e573/rtb-04259fa091fd36145"
}

import {
  to = aws_route_table_association.private_b
  id = "subnet-030123e9cebb3a459/rtb-076d0fd4736a237d4"
}

import {
  to = aws_security_group.app_server
  id = "sg-08f94aa2cbd4272e9"
}

import {
  to = aws_vpc_security_group_ingress_rule.ssh
  id = "sgr-0a62f816dde9d36a0"
}