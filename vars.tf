# aqui declaramos as variáves referentes aos amis utilizados nomeando de "amis"
variable "amis" {
    #declaramos o tipo da variável map e especificamos que serão Strings.
    type = map(string)

    # aqui fazemos o mapeamento das variáveis, com um nome de referência e seus respectivos valores
    default = {
        "us-east-1" = "ami-04505e74c0741db8d"
        "us-east-2" = "ami-0c7478fd229861c57"
    }
  
}