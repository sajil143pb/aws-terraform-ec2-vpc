resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/24"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"
  
  }

resource "aws_subnet" "prod-subnet-public" {
   vpc_id = aws_vpc.myvpc.id
   cidr_block = "10.0.1.0/24"
   availability_zone = "us-east-1"
   map_public_ip_on_launch = "true"
   
   tags = {
    "name" = "public"
   }

}

resource "aws_subnet" "prod-subnet-private" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1"
    map_public_ip_on_launch = "true"

    tags = {
      "Name" = "private"
    }
  
}

resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
    "Name" = "internetgateway"
    }
  
}

resource "aws_route_table" "prod-public-route" {
  vpc_id = aws_vpc.myvpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    "Name" = "prod-public-route"
  }
  
}

resource "aws_route_table_association" "prod-route" {
   subnet_id = aws_subnet.prod-subnet-public.id
   route_table_id = aws_route_table.prod-public-route.id
}