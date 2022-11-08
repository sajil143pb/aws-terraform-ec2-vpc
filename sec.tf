resource "aws_security_group" "websec" {
    description = "Security group for webserver"
      egress  {
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
}

      ingress  {
        description = "inbound ports for webserver"
        from_port = 80
        protocol = "TCP"
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]      

      }
}
