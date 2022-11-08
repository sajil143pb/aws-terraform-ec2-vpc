data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
      name = "name"
      values = [ "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server" ]
    }
    filter {
      name = "virtualization type"
      values = [ "hvm" ]
    }  

    owners = [ "099720109477" ]
}


resource "aws_instance" "webserver" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    availability_zone = var.REGION
    key_name = "key.pub"
    tags = {
        "name" = "webserver"
    } 
}