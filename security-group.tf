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

# sempre atento para que não haja mais de um recurso com o mesmo nome("access-ssh-us-east-2")
resource "aws_security_group" "access-ssh-us-east-2" {
    provider = aws.us-east-2 # aqui definimos a qual provider o recurso irá atender
    name = "access-ssh"
    description = "access-ssh"


    ingress = [ {
      cidr_blocks = [ "191.7.221.142/32" ] 
      description = null
      from_port = 22
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "tcp"
      security_groups = []
      self = false
      to_port = 22
    } ]


    tags = {
        Name = "ssh"
    }
  
}