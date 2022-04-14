# Este script é responsáve por configurar o versionamento da configuração e projeto no Terraform Cloud
terraform {
    # o recurso cloud deve ser único, não podendo repeti-lo em nenhum momento
    cloud {
        # aqui será configurado a organização que foi criado na sua conta no terraform cloud
        organization = "meus-estudos-terraform"

        # este é o host de acesso que é padrão do terraform
        # hostname = "app.terraform.io" # Optional; defaults to app.terraform.io

        # Aqui será configurado o workspace a ser utilizando
        workspaces {
            name = "primeiros-passos-terraform"
        }
    }
    
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.9.0"
        }
    }
}