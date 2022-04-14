# com o provide definimos o provedor que será usado no projeto
provider "aws" {
  region = "us-east-1" # no caso do aws é necessário definir a regial 
}

# quando é necessário trabalhar com mais de uma região, primeiramente precisamos configurar um provider
# com a região em questão, diferenciando através de alias
provider "aws" {
  alias = "us-east-2"
  region = "us-east-2"
}

# com o resource podemos iniciar qualquer recurso passado como parametro o 
# tipo de recurso "aws_instance" e um nome para ele "dev"
resource "aws_instance" "dev" {
    count = 1 # o Count permite especificar quantas instandcias serão criadas com as mesmas configurações
    ami = var.amis["us-east-1"] # O Ami é a identificação da imagem a ser usada para criar a EC@
    instance_type = var.instance_type # instance_type especifica qual modelo da máquina a ser usada, neste caso a t2.micro que foi declarado na variável
    key_name = var.key_name  # Aqui será o nome da chave criada aneriormente e importada para o AWS EC2 (akterada para a variável declarada com o nome da chave)

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
    ami = var.amis["us-east-1"] 
    instance_type = var.instance_type
    key_name = var.key_name 

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

# Iremos usar o dev3 para associar ao novo provedor
resource "aws_instance" "dev3" {
    provider = aws.us-east-2 # assim identificamos a qual provedor(região) atende

    # aqui a ami foi substituida por variáveis, onde foram declaradas em um arquivo diferente
    ami = var.amis["us-east-2"] # vamos alterar para uma ami da amazon
    instance_type = var.instance_type # subistituido por uma variável
    key_name = var.key_name # subistuindo o texto por uma variável declarada com a chave

    tags = {
      Name = "dev3" 
    }

    # também sendo necessário atualizar o security group
    vpc_security_group_ids = [ "${aws_security_group.access-ssh-us-east-2.id}" ]
    # dependencia do banco
    depends_on = [
      aws_dynamodb_table.dynamodb_homologacao
    ]

}

resource "aws_dynamodb_table" "dynamodb_homologacao" {
  provider = aws.us-east-2
  name = "Database-dev3"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "UserId"
  range_key = "DatabaseTitle"

  attribute {
    name = "UserId"
    type = "S"
  }
  
  attribute {
    name = "DatabaseTitle"
    type = "S"
  }
}

# OBS.:
# resource "aws_security_group" "access-ssh" foi separado para um arquivo security-group.tf
# Podemos separar nosso código entre arquivo.tf, desde que os arquivos estejam no formato .tf
# o terrraform sempre identificará o que está dentro do arquivo, independente no seu nome.

# instanciando um bucket chamado
# Bucket são multiregionais, não precisa definir região
resource "aws_s3_bucket" "dev2" {
    bucket = "primeirospassos-dev2" #Nome do bucket

    tags = {
      Name = "primeirospassos-dev2"
    }
  
}