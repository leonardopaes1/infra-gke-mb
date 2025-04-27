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
- [Crypto API App Repository](https://github.com/seu-usuario/desafio-mb-aplication)

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

| Secret             | Descrição                                 |
|--------------------|-------------------------------------------|
| `GCP_CREDENTIALS`  | JSON de autenticação da Service Account |

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