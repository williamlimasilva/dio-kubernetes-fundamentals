# Convenção Baseada em Componente + Função + Tipo

## Estrutura da Convenção

### `<componente>`:

- Representa o nome da aplicação, serviço ou módulo da sua arquitetura.
- Deve ser curto, descritivo e específico ao contexto da sua aplicação.
- **Exemplos**: `web`, `api`, `db`, `auth`, `myapp`.

### `<função>`:

- Indica o papel ou propósito do recurso dentro do componente.
- Ajuda a diferenciar recursos do mesmo componente com funções distintas.
- **Exemplos**: `lb` (load balancer), `frontend`, `backend`, `worker`, `replica`, `cache`.

### `<tipo>`:

- Refere-se ao tipo de recurso Kubernetes (e.g., Service, Deployment, ConfigMap).
- Geralmente usa abreviações curtas e padronizadas para manter o nome conciso.
- **Exemplos comuns**:
  - `svc`: Service
  - `deploy`: Deployment
  - `cm`: ConfigMap
  - `secret`: Secret
  - `ing`: Ingress
  - `sts`: StatefulSet
  - `job`: Job

### `<ambiente>` (opcional):

- Especifica o ambiente onde o recurso será usado (e.g., `prod`, `dev`, `staging`).
- Útil para distinguir recursos idênticos em diferentes contextos.
- **Exemplos**: `prod`, `dev`, `test`, `qa`.

---

## Regras Práticas

1. **Use hífens**: Separe cada parte com `-` para seguir a convenção Kubernetes e facilitar a legibilidade.
2. **Minúsculas**: Mantenha tudo em letras minúsculas para compatibilidade com DNS.
3. **Evite redundância**: Não repita informações já implícitas (e.g., evitar `svc-lb` se o tipo já é `Service` e a função é `load balancer`).
4. **Seja consistente**: Use os mesmos termos para funções e tipos em todo o projeto.

---

## Exemplos Aplicados

### Contexto: Aplicação Web Simples

- **Componente**: `web` (uma aplicação web genérica).
- **Ambiente**: Opcional, vamos usar `prod` em alguns casos.

| Recurso Kubernetes      | Função     | Nome do Arquivo            | Nome do Recurso (`metadata.name`) |
| ----------------------- | ---------- | -------------------------- | --------------------------------- |
| Service (Load Balancer) | `lb`       | `web-lb-svc.yaml`          | `web-lb`                          |
| Deployment              | `frontend` | `web-frontend-deploy.yaml` | `web-frontend`                    |
| ConfigMap               | `config`   | `web-config-cm.yaml`       | `web-config`                      |
| Secret                  | `secrets`  | `web-secrets-secret.yaml`  | `web-secrets`                     |
| Ingress                 | `ingress`  | `web-ingress-ing.yaml`     | `web-ingress`                     |
| Service (Interno)       | `backend`  | `web-backend-svc.yaml`     | `web-backend`                     |
| Service (Prod)          | `lb`       | `web-lb-svc-prod.yaml`     | `web-lb-prod`                     |

### Contexto: API com Múltiplos Componentes

- **Componente**: `api` (uma API backend).
- **Ambiente**: `staging`.

| Recurso Kubernetes      | Função     | Nome do Arquivo           | Nome do Recurso (`metadata.name`) |
| ----------------------- | ---------- | ------------------------- | --------------------------------- |
| Service (Load Balancer) | `lb`       | `api-lb-svc-staging.yaml` | `api-lb-staging`                  |
| Deployment              | `worker`   | `api-worker-deploy.yaml`  | `api-worker`                      |
| ConfigMap               | `settings` | `api-settings-cm.yaml`    | `api-settings`                    |
| StatefulSet             | `db`       | `api-db-sts.yaml`         | `api-db`                          |

---

## Aplicação ao Seu Serviço de Load Balancer

### Suposições

- **Componente**: `app` (genérico, substitua pelo nome real da sua aplicação, como `web` ou `api`).
- **Função**: `lb` (indicando load balancer).
- **Tipo**: `svc` (Service do tipo LoadBalancer).
- **Ambiente**: Opcional, vamos usar `prod` como exemplo.

### Resultado

- **Nome do Arquivo**: `app-lb-svc.yaml` (sem ambiente) ou `app-lb-svc-prod.yaml` (com ambiente).
- **Nome do Recurso**: `app-lb` ou `app-lb-prod`.

### Exemplo de YAML

#### Sem ambiente:

```yaml
apiVersion: v1
kind: Service
metadata:
    name: app-lb
spec:
    type: LoadBalancer
    ports:
        - port: 80
            targetPort: 8080
            protocol: TCP
    selector:
        app: app-frontend
```

#### Com ambiente:

```yaml
apiVersion: v1
kind: Service
metadata:
    name: app-lb-prod
spec:
    type: LoadBalancer
    ports:
        - port: 80
            targetPort: 8080
            protocol: TCP
    selector:
        app: app-frontend
```

---

## Variações e Ajustes

### Abreviações de Função:

- `lb` → load balancer
- `en` → external name
- `np` → node port
- `cl`→ cluster ip
- `fe` → frontend
- `be` → backend
- `db` → database

### Sem Função Explícita:

- Se a função for implícita (e.g., um único Service por componente), você pode omiti-la: `app-svc.yaml`.

### Projetos Grandes:

- Adicione um prefixo de projeto, como `ecommerce-app-lb-svc.yaml`, se necessário.

---

## Padronização para o Projeto

### Template

`<componente>-<função>-<tipo>-(ambiente)`

### Dicionário de Termos

- **Componentes**: `web`, `api`, `db`, `auth`
- **Funções**: `lb`, `frontend`, `backend`, `worker`, `cache`
- **Tipos**: `svc`, `deploy`, `cm`, `secret`, `ing`, `sts`
- **Ambientes**: `prod`, `dev`, `staging`, `qa`

### Exemplo completo para um sistema:

- `web-frontend-deploy-prod.yaml`
- `web-lb-svc-prod.yaml`
- `db-cache-sts-prod.yaml`
