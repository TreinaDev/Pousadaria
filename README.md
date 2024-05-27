# Pousadaria

Com o fim da pandemia, muitas pessoas estão voltando a viajar e conhecer novos lugares em todo o Brasil. Aproveitando este cenário, nosso cliente nos contratou para iniciar uma nova startup, 100% brasileira, focada no aluguel de quartos em pousadas, afinal, nada mais aconhegante do que as pousadas com seus cafés da manhã e aquele ambiente mais intimista que o dos grandes hotéis.

## Funcionalidades

Este projeto ainda está incompleto, mas na versão atual as funcionalidades listadas abaixo já estão disponíveis:

### Criar conta como dono de pousada

Um usuário pode criar sua conta como dono de uma pousada informando seu e-mail, uma senha, primeiro nome, último nome e CPF.

### Cadastrar pousada

Com sua conta criada, o usuário deve, obrigatoriamente, cadastrar sua pousada informando nome, CNPJ e endereço completo com endereço, bairro, estado, cidade e CEP. 

### Adicionar quartos

Um usuário autenticado como dono de pousada pode adicionar quartos a uma pousada. Cada quarto deve possuir um nome, uma descrição em texto, sua dimensão (em m2), a quantidade máxima de pessoas que podem se hospedar e um valor padrão da diária a ser cobrada. Um quarto também pode ter uma foto.

## Instalação e Execução

### Pré Requisitos

Você vai precisar da versão `3.2.0` do Ruby e uma versão atual de NodeJS com Yarn instalado. Recomendamos sempre a instalação das versões LTS (Long Term Support).

### Passo a passo

1. Faça um [fork](https://docs.github.com/pt/get-started/quickstart/fork-a-repo#forking-a-repository) deste repositório em sua conta pessoal do Github.

2. Após a criação do novo repositório em sua conta, faça um  `git clone` da sua versão do Pousadaria para seu computador. 

3. Depois de clonar o repositório, acesse o diretório do projeto e rode os comandos:

```shell
bin/setup
```

Atente-se que o comando `bin/setup` vai executar o comando `yarn install`. 


4. Para popular a aplicação com alguns dados, execute:

```shell
rails db:seed
```


5. Esta aplicação possui dependências de CSS e JS isoladas do Gemfile. Por isso o processo de execução da app em `localhost` não deve ser feito somente com `rails server`. Para rodar a aplicação, rode o comando:

```shell
bin/dev
```

Para conhecer mais sobre este comando, leia seu código fonte na pasta `bin` do projeto e conheça mais sobre a gem [Foreman](https://github.com/ddollar/foreman)

6. Acesse `localhost:3000` em seu navegador de preferência e veja se está tudo ok.

7. Para rodar os testes, execute:

```shell
 rake spec
```