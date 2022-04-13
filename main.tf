# com o provide definimos o provedor que será usado no projeto
provider "aws" {
    region = "us-east-1" # no caso do aws é necessário definir a regial 
}

# com o resource podemos iniciar qualquer recurso passado como parametro o 
# tipo de recurso "aws_instance" e um nome para ele "dev"
resource "aws_instance" "dev" {
    count = 1 # o Count permite especificar quantas instandcias serão criadas com as mesmas configurações
    ami = "ami-04505e74c0741db8d" # O Ami é a identificação da imagem a ser usada para criar a EC@
    instance_type = "t2.micro" # instance_type especifica qual modelo da máquina a ser usada, neste caso a t2.micro
    key_name = "terraform-aws" # Aqui será o nome da chave criada aneriormente e importada para o AWS EC2

    tags = {
      Name = "dev${count.index}"
    }
}