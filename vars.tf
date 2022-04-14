# aqui declaramos as variáves referentes aos amis utilizados nomeando de "amis"
variable "amis" {
    # caso não declare o type, o terraforma assume por padrão o tipo string.
    #declaramos o tipo da variável map e especificamos que serão Strings.
    type = map(string)

    # aqui fazemos o mapeamento das variáveis, com um nome de referência e seus respectivos valores
    default = {
        "us-east-1" = "ami-04505e74c0741db8d"
        "us-east-2" = "ami-0c7478fd229861c57"
    }
  
}

# Para facilitar a tualização dos ips de acesso no security group
# podemos criar uma variável para guardar uma lista de ips, onde facilitaŕa a atualização
# quando um ip for removido ou add
variable "cidr_acesso_remoto" {
    type = list # aqui vamos utilizar vafiável do tipo lista

    # Aqui vamos declarar os valores da lista
    default = ["191.7.221.142/32"]
  
}

variable "key_name" {

    default = "terraform-aws"
}

variable "instance_type" {
    default = "t2.micro"
  
}