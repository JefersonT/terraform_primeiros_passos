# com o provide definimos o provedor que será usado no projeto
provider "aws" {
    region = "us-east-1" # no caso do aws é necessário definir a regial 
}

resource "aws_instance" "dev" {
    count = 1
    
  
}