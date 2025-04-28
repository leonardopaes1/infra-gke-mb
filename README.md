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

- Terraform 1.11.4
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
    - `roles/monitoring.editor`
    - `roles/logging.viewer`
- 🔑 Gerar a chave JSON dessa Service Account (usada na Secret `GCP_CREDENTIALS`).

- 🪣 Criar um **bucket no GCS** para ser utilizado como **backend** do Terraform:
  - Exemplo de comando para criação:
    ```bash
    gsutil mb -p [PROJECT_ID] -l [REGION] gs://[BUCKET_NAME]
    ```
  - E conceder à Service Account permissão `storage.admin` no bucket.

- ⚙️ Criar as secrets de Actions no Github com os nomes listados abaixo e seus respectivos valores.
- 🛠️ AHabilitar PIs obrigatórias no Google Cloud

    | API | Nome no Console | ID Técnico |
    |:---|:-----------------|:-----------|
    | Kubernetes Engine API | Kubernetes Engine API | `container.googleapis.com` |
    | Cloud Resource Manager API | Cloud Resource Manager API | `cloudresourcemanager.googleapis.com` |
    | IAM Service Account Credentials API | IAM Service Account Credentials API | `iamcredentials.googleapis.com` |

  **Habilitar Via CLI:**

  ```bash
  gcloud services enable container.googleapis.com
  gcloud services enable cloudresourcemanager.googleapis.com
  gcloud services enable iamcredentials.googleapis.com
  ```

---

## 🔒 Secrets Necessárias (GitHub)

| Secret Name            |  Valor da Secret Conforme a Descrição                                           |
|-------------------|---------------------------------------------------------|
| `GCP_CREDENTIALS`  | Chave JSON do Service Account com permissões adequadas |
| `PROJECT_ID`       | ID do projeto GCP onde a infraestrutura será criada    |
| `CLUSTER_NAME`     | Nome do cluster GKE a ser criado                       |
| `ALERT_EMAIL`      | E-mail do proprietário ou responsável pela infraestrutura |
| `TFSTATE_BUCKET`   | Nome do bucket GCS onde será armazenado o Terraform State |
| `PROD_NODE_NUMBER`   | Quantidade de nodes para o pool de produção |
| `STAGING_NODE_NUMBER`   | Quantidade de nodes para o pool de staging |




---

## ⚙️ Provisionamento

- Criação de Cluster Kubernetes (GKE)
- Node Pools para staging e produção
- Alerta Pod Restart Anormal

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
- Criar as secrets de Actions no Github permitindo passar variáveis dinamicamente para a criação do modulo terraform possibilitando aumento do número de node pools e reaproveitamento de código para outros projeto.

---

## 🚀 Caso Queira Executar Local

Antes de rodar o Terragrunt, exporte as variáveis de ambiente obrigatórias:

```bash
export GCP_PROJECT_ID="seu-project-id"
export CLUSTER_NAME="nome-do-cluster"
export EMAIL_ALERT="email-do-service-account"
export TFSTATE_BUCKET="nome-do-bucket-tfstate"
export PROD_NODE_NUMBER="Número de nodes para o pool de produção"
export STAGING_NODE_NUMBER="Número de nodes para o pool de staging"


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