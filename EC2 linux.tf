provider "aws" {
  region = "sa-east-1"
}
#####criar Security Group#########
resource "aws_security_group" "SG" {
  name        = "SG-TESTE-API"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-088bd961"

  ingress {
    description = "Acesso ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["52.67.54.18/32"]
  }
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "lx" {


  ami                    = "ami-01561953b4a786937"
  instance_type          = "t3a.micro"
  key_name               = "INFRA_KEY"
  user_data              = "${file("userdata.sh")}"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.SG.id]
  subnet_id              = "subnet-0a8bd963"


  tags = {
    Name     = "teste-api-userdata"
    Ambiente = "teste"
    Projeto  = "teste"
    Setor    = "Tecnologia"
  }
}
###########Criando discos
resource "aws_ebs_volume" "app" {
  availability_zone = "sa-east-1a"
  size              = 2

  tags = {
    name     = "[teste-app]"
    Ambiente = "Producao"
    Projeto  = "Unyco"
    Setor    = "Tecnologia"
  }


}
resource "aws_volume_attachment" "ebs_at1" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.app.id
  instance_id = aws_instance.lx.id
}
