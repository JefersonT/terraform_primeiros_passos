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

    # com o tags podemos nomear a instância
    tags = {

        # Por se tratar de vários dispositivos podemos 
        # colocar uma referencia ao count para mudar o nome das instancias de acordo com a quantidade
      Name = "dev${count.index}" 
    }

    # vpc_security_group_ids defini qual security group a instância vai utiliza,
    # caso não seja definido irá usar a vpc defaut da EC2
        # A entrada pode ser uma string do id da security group 
        # ou uma referencia do comando AWS CLI para identificar o id
    vpc_security_group_ids = [ "${aws_security_group.access-ssh.id}" ] 

}

# o nome passado no parametro do resource é para referencia local no código.
resource "aws_instance" "dev2" {
    ami = "ami-04505e74c0741db8d" 
    instance_type = "t2.micro" 
    key_name = "terraform-aws" 

    tags = {
      Name = "dev2" 
    }

    vpc_security_group_ids = [ "${aws_security_group.access-ssh.id}" ]

    # depends_on cria uma dependência entre o instância e o recurso referenciado
    # assim o dev2 só executa após a execução do bucket
    depends_on = [
        aws_s3_bucket.dev2 # Referencia do recurso.nome
    ]

}

resource "aws_instance" "dev3" {
    ami = "ami-04505e74c0741db8d" 
    instance_type = "t2.micro" 
    key_name = "terraform-aws" 

    tags = {
      Name = "dev3" 
    }

    vpc_security_group_ids = [ "${aws_security_group.access-ssh.id}" ]

}


# Este recurso cria um novo grupo de acesso chamado "access-ssh"
resource "aws_security_group" "access-ssh" {
    name = "access-ssh" # Defini o nome do security group
    description = "access-ssh" # Defini uma descrição para o security group

    # o ingress defini o firewall de entrado da instãncia
    ingress = [ {
      cidr_blocks = [ "191.7.221.142/32" ] # Lista de ips com acessos permitidos
      description = null # descirção da regra
      from_port = 22 # porta que se aplica a regra
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "tcp" # tipo de protocolo
      security_groups = []
      self = false
      to_port = 22 # porta que se aplica a regra
    } ]

    # define um noma tag para a instãncia
    tags = {
        Name = "ssh"
    }
  
}

# instanciando um bucket chamado
# Bucket são multiregionais, não precisa definir região
resource "aws_s3_bucket" "dev2" {
    bucket = "primeirospassos-dev2" #Nome do bucket

    tags = {
      Name = "primeirospassos-dev2"
    }
  
}