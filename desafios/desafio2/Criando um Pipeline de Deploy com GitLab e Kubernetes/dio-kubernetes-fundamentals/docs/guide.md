# Criar e Automatizar uma Imagem Docker

### 1. Criar a Estrutura do Projeto

- Criar um diretório para a aplicação:
  ```sh
  mkdir minha-aplicacao && cd minha-aplicacao
  ```
- Adicionar os arquivos do projeto, incluindo o `index.html`.

### 2. Criar o Dockerfile

- Criar um arquivo `Dockerfile` com o seguinte conteúdo:

```dockerfile
FROM php:7.4-apache

WORKDIR /var/www/html

COPY incluir.php /var/www/html
COPY conexao.php /var/www/html
COPY js.js /var/www/html
COPY index.html /var/www/html
COPY css.css /var/www/html

RUN apt-get update && apt-get install -y \
 libfreetype6-dev \
 libjpeg62-turbo-dev \
 libpng-dev \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j$(nproc) gd \
 && docker-php-ext-install pdo_mysql

EXPOSE 80
```

### 3. Construir a Imagem Docker

- No terminal, dentro do diretório do projeto, executar:

```sh
docker build -t minha-aplicacao:1.0 .
```

### 4. Criar um Contêiner com a Imagem

- Executar o seguinte comando para rodar o contêiner:
  ```sh
  docker run -d -p 80:80 --name minha-aplicacao minha-aplicacao:1.0
  ```
- Acessar `http://localhost` para verificar se a aplicação está rodando.

### 5. Criar Conta no Docker Hub e Fazer Login

- Criar conta no [Docker Hub](https://hub.docker.com/).
- No terminal, fazer login:
  ```sh
  docker login -u meu_usuario -p minha_senha
  ```

### 6. Publicar a Imagem no Docker Hub

- Renomear a imagem para o repositório do Docker Hub:

```sh
  docker tag minha-aplicacao:1.0 meu_usuario/minha-aplicacao:1.0
```

- Fazer o upload da imagem:

```sh
 docker push meu_usuario/minha-aplicacao:1.0
```

### 7. Automatizar o Build e Deploy com CI/CD (GitLab CI/CD)

- Criar um arquivo `.gitlab-ci.yml` no repositório:

  ```yaml
  stages:
    - build
    - deploy

  build:
    image: docker:28.0
    services:
      - docker:28.0-dind
    script:
      - docker login -u "$DOCKER_USER" -p "$DOCKER_PASSWORD"
      - docker build -t "$DOCKER_USER/minha-aplicacao:latest" .
      - docker push "$DOCKER_USER/minha-aplicacao:latest"

  deploy:
    stage: deploy
    script:
      - echo "Futuro deploy na AZURE/GCP/AWS/Kubernetes"
  ```

- Configurar variáveis `DOCKER_USER` e `DOCKER_PASSWORD` no GitLab CI/CD Settings.
- Ao fazer push no repositório, a imagem será gerada e publicada automaticamente.

### 8. Testar a Imagem Publicada

- Para rodar a imagem publicada, usar:

```sh
 docker run -d -p 80:80 meu_usuario/minha-aplicacao:latest
```

- Acessar `http://localhost` para verificar a aplicação.

### 9. Automatizar o Deploy para Kubernetes

- Criar um arquivo `deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minha-aplicacao
spec:
  replicas: 2
  selector:
    matchLabels:
      app: minha-aplicacao
  template:
    metadata:
      labels:
        app: minha-aplicacao
    spec:
      containers:
        - name: minha-aplicacao
          image: meu_usuario/minha-aplicacao:latest
          ports:
            - containerPort: 80
```

- Aplicar no Kubernetes:

```sh
  kubectl apply -f deployment.yaml
```

### Conclusão

Esse processo permite criar uma imagem Docker, publicá-la automaticamente no Docker Hub e configurar um sistema de deploy automatizado em Kubernetes ou outro provedor de nuvem.
