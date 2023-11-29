# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

## Como rodar o projeto

### Setup

#### Bun

[Instale o Bun](https://bun.sh/docs/installation)

Então rode:

```bash
bun install
```

#### Ruby

Usa a **versão do ruby correta** (olha a Gemfile, atualmente é a 2.7.5).

```bash
bundle install
```

```bash
rails db:create
```

```bash
rails db:migrate
```

### Rodando para desenvolvimento

Tente rodar direto o projeto:

```bash
./bin/dev
```

Caso necessário gerar um secret

```bash
./bin/rails secret
```

### Rodando os testes

#### Cucumber

```bash
cucumber features/path/to/file.feature

```
