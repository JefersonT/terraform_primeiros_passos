# com o output podemos definir dados de saida ao executar um apply, refresh ou output. 
# Importante para receber alguns dados dos recursos no momento da criação.
# Para funcionar o recurso deve está em execução

# No output definimos um nome para ele, ajudarar a identificar no momento da saida
output "dev2" {
    # Com o value definimos qual informção queremos da determinada instácia de cada recurso
    value = aws_instance.dev2.public_ip
  
}

output "dev3" {
    value = aws_instance.dev3.public_ip
  
}