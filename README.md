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

## Anotações
- Multiplos arquivos de configurações:
    - A partir da versão v1.1.0, estaremos trabalhando com muiltiplos arquivo **.tf**. Dessa forma podemos organizar a configuração da infraestrutura separando cada recurso em arquivos distintos. Exemplo: manter no *main.tf* as instancias principais e separando alguns recursos secundário como os *security group* em um arquivo separado.
    - Não há a necessidade de padronizar o nome do arquivo. O terraform já identifica tudo automaticamente, desde que os arquivos estejam todos com a extensão **.tf** e estejam na mesma estrutura de diretório.
- Multiplas Regiões:
    - Também vemos a utilização de mais de uma região. Esse recurso é proporcionado através da declaração de um segundo provedor aws, porém com um **alias** para identifica-lo e referencia-lo nos recursos que serão servidos por ele.
    - Para este recurso funcionar corretamente é necessário importar novamente a chave publica criada anteriormente, porém logado no AWS utilizando a outra região a qual será criado os serviços. Sem esse procedimento o terraform não conseguirar estabelecer uma conexão com o provedor.
- Criação de Banco de Dados:
    - Também podemos observar a utilização de um novo serviço o **dynamodb**, sendo configurado para ser a dependência da instancia *dev3*.
- Criação de Variáveis
    - Podemos criar variáves para referenciar na criação de recuros, facilitando na mudança dessas informações quando forem alteradas. Para manter as boas práticas separamos as variáveis em um arquivo *vars.rf*.
- Formas de excluir recursos:
    - Remover as linhas de códigos do recurso. Ao apagar as linhas onde declara um recurso, no momento do `$ terraform plan` ou `$ terraform apply`, o terraform identifica automaticamente que aqueles recursos devem ser destroidos. O mesmo vale para a ação de comentar o código.
    - Um forma de remover o recurso sem mexer no código é através do seguinte comando, onde é especificado o recurso a ser destroido (desta forma também irá destroir os recursos que são dependentes do recurso destroido):
        ```
        $ terraform destroy -target tipo_do_resource.nome
        ```
    - Caso tenha terminado os estudos ou projeto e queira remover tudo para não continuar gastando os recursos, basta executar o seguinte comando:
        ```
        $ terraform destroy
        ```
- Utilizando Output:
    - Com o output podemos definir dados de saida ao executar um `$ terraform apply`, `$ terraform refresh` ou `$ terraform output`. Importante para receber alguns dados dos recursos no momento da criação. Para funcionar o recurso deve está em execução.
- Utilizando terraform cloud
    - Esse recurso premite versionar o projeto e trabalhar colaborando com a equipe sem que haja impacto na utilização.

