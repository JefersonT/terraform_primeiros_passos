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

### Configurar o Ambiente
1. Conta na [AWS](https://aws.amazon.com/)
2. Criar um novo usuário apartir do IAM
    - Nome: **terraform-aws**.
    - Access type: **Programmatic Access**.
    - Criar no grupo de acesso com acesso **Administrador Full**.
    - Baixar e guardar o *arquivo.csv*.
3. Configure o AWS CLI
    - Executar:
        ```
        $ aws configure
        ```
    - Com os dados do *arquivo.csv* prencha os dados de **AWS Access Key ID** e **AWS Secret Access Key**.
    - Defina a regial defaut de sua preferência.
    - Defina o output do arquivo como **json**.
4. Criar chave ssh
    - Executa:
        ```
        $ ssh-keygen -f terraform-aws -t rsa
        ```
    - Guarde a chave privada em um lugar seguro.
    - Importe a chave publica para o AWS EC2.



