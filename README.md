# 🚀 Projeto: Provisionar cluster de GKE com terragrunt

## 🎯 Objetivo

Provisionar a infraestrutura na Google Cloud Platform utilizando Terraform + Terragrunt, configurando GKE, rede, bucket de backend, segurança e observabilidade.

---

## 📦 Estrutura

- **Terraform + Terragrunt** para gerenciar a infraestrutura.
- **GKE** (Google Kubernetes Engine) com cluster zonal (`us-central1-c`).
- **Buckets GCS** para armazenar o `terraform.tfstate`.
- **Observabilidade** via Google Cloud Monitoring (Dashboards e Alertas).

---

## 🔗 Repositório da Aplicação

O código da aplicação Go e Helm Chart estão disponíveis aqui:
- [leonardopaes1/crypto-api-mb](https://github.com/leonardopaes1/crypto-api-mb)

---

## 🛠️ Ferramentas Utilizadas

- Terraform 1.7.5
- Terragrunt 0.57.4
- GCP CLI (gcloud)
- GitHub Actions

---

## 🔔 Pré-requisitos

Antes de iniciar o provisionamento da infraestrutura, é necessário:

- 📄 Criar uma **Service Account** no Google Cloud com as seguintes permissões:
  - `roles/owner` **(recomendado para ambientes de teste)** ou permissões específicas mínimas:
    - `roles/container.admin`
    - `roles/compute.admin`
    - `roles/iam.serviceAccountUser`
    - `roles/storage.admin`
    - `roles/monitoring.admin`
- 🔑 Gerar a chave JSON dessa Service Account (usada na Secret `GCP_CREDENTIALS`).

- 🪣 Criar um **bucket no GCS** para ser utilizado como **backend** do Terraform:
  - Exemplo de comando para criação:
    ```bash
    gsutil mb -p [PROJECT_ID] -l [REGION] gs://[BUCKET_NAME]
    ```
  - E conceder à Service Account permissão `storage.admin` no bucket.

- ⚙️ Definir o nome do bucket no `backend` dos módulos de Terragrunt.

---

## 🔒 Secrets Necessárias (GitHub)

| Secret            | Descrição                                              |
|-------------------|---------------------------------------------------------|
| `GCP_CREDENTIALS`  | Chave JSON do Service Account com permissões adequadas |
| `PROJECT_ID`       | ID do projeto GCP onde a infraestrutura será criada    |
| `CLUSTER_NAME`     | Nome do cluster GKE a ser criado                       |
| `OWNER_EMAIL`      | E-mail do proprietário ou responsável pela infraestrutura |
| `TFSTATE_BUCKET`   | Nome do bucket GCS onde será armazenado o Terraform State |

---

## ⚙️ Provisionamento

- Criação de VPC e subnets públicas
- Criação de Cluster Kubernetes (GKE)
- Node Pools para staging e produção
- Backend remoto no GCS
- Permissões IAM configuradas para SA

---

## 🌐 Observabilidade

- Dashboard criado no GCP Monitoring:
  - Monitoramento de CPU/Memory/Restart dos Pods
  - Healthcheck via Uptime Check

- Alertas configurados:
  - Pod Restart Anormal
  - Falha no Healthcheck da aplicação

---

## 📋 Decisões Técnicas

- Separação de ambientes (`staging` / `prod`) por branches e tags
- Uso de GitHub Actions para automação CI/CD da infraestrutura
- Preferência por soluções nativas GCP para observabilidade
- Uso de Service Account Key segura via GitHub Secrets

---

## 🚀 Caso Queira Executar Local

Antes de rodar o Terragrunt, exporte as variáveis de ambiente obrigatórias:

```bash
export GCP_PROJECT_ID="seu-project-id"
export CLUSTER_NAME="nome-do-cluster"
export EMAIL_ALERT="email-do-service-account"
export TFSTATE_BUCKET="nome-do-bucket-tfstate"
```

```bash
cd terraform/terragrunt/gke

terragrunt init      # Inicializa backend e providers
terragrunt plan      # Exibe o plano de execução
terragrunt apply     # Aplica a infraestrutura
```

---

## ✅ Status

| Item | Status |
|:---|:---|
| Infraestrutura provisionada | ✅ |
| Observabilidade configurada | ✅ |
| CI/CD da Infraestrutura funcionando | ✅ |

---

## 📄 Licença

Este projeto é open-source para fins de estudo e demonstração de habilidades DevOps/SRE.

---