data "aws_ami" "latest" {
    most_recent = true
    
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    
    owners = ["137112412989"] # Amazon
    }
    
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = var.vpc_id
}

 
resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.web_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.latest.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web_sg.name]
  subnet_id     = var.subnet_id
      
  tags = {
    Name = "WebInstance"
  }
}

