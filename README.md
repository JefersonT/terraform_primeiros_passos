# Primeiros passos com Terraform

<p>Este projeto foi desenvolvido com o objetivo de praticar os conhecimento adiquirido ao longo do Curso de
Terraform: automatize a infraestrutura na nuvem. Neste projeto é utilizado como base o provedor AWS. Aqui será apresentado a evolução do projeto e boas práticas a serem tomadas ao evoluir nas releases.</p>


## Pré-requisitos
### Conhecimento necessário:
- AWS
    - EC2
    - IAM
    - S3
- Redes de Computadores
- Linux

### Instalação necessária:
- [Terraform](https://www.terraform.io/downloads)
- [AWS CLI](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/getting-started-install.html)

### Configurando o Ambiente
1. Criar conta na [AWS](https://aws.amazon.com/)
2. Criar um novo usuário apartir do IAM
    - Nome: **terraform-aws**.
    - Access type: **Programmatic Access**.
    - Criar no grupo de acesso com acesso **Administrador Full**.
    - Baixar e guardar o *arquivo.csv*.
3. Configure o AWS CLI
    - Acesso o Terminal.
    - Executar:
        ```
        $ aws configure
        ```
    - Com os dados do *arquivo.csv* prencha os dados de **AWS Access Key ID** e **AWS Secret Access Key**.
    - Defina a região defaut de sua preferência.
    - Defina o output do arquivo como **json**.
4. Criar chave ssh
    - Acesso o Terminal.
    - Executa:
        ```
        $ ssh-keygen -f terraform-aws -t rsa
        ```
    - Guarde a chave privada em um lugar seguro.
    - Importe a chave publica para o AWS EC2.
    - Caso crie a chave com um nome diferente é necessário alterar o valor no campo `key_name = "terraform-aws"` no arquivo *main.tf* para o nome que foi utilizado.
### Executando o projeto
1. Alterar o ip no campo `cidr_blocks = [ "191.7.221.142/32" ]` em `ingress [{}]` para o ip publico de sua máquina.
2. Altere os valores dos campos `bucket = "primeirospassos-dev2"` e `Name = "primeirospassos-dev2"`, pois os mesmos devem ser únicos.
3. Acesse o diretório do projeto apartir do terminal.
4. Execute o seguinte comando para iniciar o ambiente e baixar as dependências:
    ```
    $ terraform init
    ```
5. Execute o seguinte comando para validar se o projeto está funcional:
    ```
    $ terraform plan
    ```
6. Execute o seguinte comando para aplicar os recursos ao AWS:
    ```
    $ terraform apply
    ```
7. Ao finalizar os testes, execute o seguinte comando para destroir todos os recursos:
    ```
    $ terraform apply -destroy
    ```



