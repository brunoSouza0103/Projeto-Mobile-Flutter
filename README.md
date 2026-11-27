# 🍽️ Menue – Aplicativo de Receitas

## 📖 Descrição

O **Menue** é um aplicativo mobile desenvolvido em Flutter, com o objetivo de facilitar a descoberta e consulta de receitas culinárias.

O aplicativo permite explorar receitas, pesquisar por nome, visualizar ingredientes e instruções de preparo e salvar receitas favoritas para acessá-las posteriormente.

Os dados são obtidos por meio da API pública [DummyJSON Recipes](https://dummyjson.com/docs/recipes), utilizando requisições HTTP.

## ✨ Funcionalidades

- **Tela inicial:** apresenta receitas em destaque e acesso rápido às principais funcionalidades.
- **Listagem de receitas:** exibe as receitas disponíveis na API em formato de grade.
- **Pesquisa:** permite localizar receitas pelo nome.
- **Detalhes da receita:** apresenta imagem, avaliação, tempo de preparo, tempo de cozimento, quantidade de porções, ingredientes e modo de preparo.
- **Favoritos:** permite adicionar e remover receitas de uma lista de favoritas.
- **Tratamento de erros:** apresenta mensagens para situações de falha na conexão, respostas inválidas e ausência de resultados.
- **Navegação inferior:** facilita o acesso às telas de início, pesquisa e favoritos.

## 🛠️ Tecnologias utilizadas

| Tecnologia | Finalidade |
|---|---|
| Flutter | Desenvolvimento da interface mobile |
| Dart | Linguagem de programação |
| DummyJSON API | Fornecimento dos dados das receitas |
| HTTP | Comunicação com a API |
| Material Design | Componentes e identidade visual |

### SDK utilizado

- **Flutter SDK:** framework utilizado para o desenvolvimento do aplicativo.
- **Dart SDK:** linguagem utilizada no desenvolvimento, disponibilizada pelo Flutter SDK.

As versões específicas dos SDKs estão definidas no arquivo `pubspec.yaml` do projeto.

## 📦 Dependências

As principais dependências utilizadas são:

- `flutter`: SDK principal do projeto.
- `http`: pacote utilizado para realizar requisições HTTP e consumir a API.

O gerenciamento dos favoritos utiliza `ChangeNotifier`, disponibilizado pelo próprio Flutter, sem necessidade de uma biblioteca externa adicional.

## 🚀 Como executar o projeto

### Pré-requisitos

Antes de executar o aplicativo, é necessário ter instalado:

- Flutter SDK.
- Dart SDK (incluído na instalação do Flutter).
- Android Studio ou Visual Studio Code.
- Emulador Android ou dispositivo físico.
- Conexão com a internet para consumir a API.

### 1. Clonar o repositório

```bash
git clone https://github.com/brunoSouza0103/Projeto-Menue.git
```

### 2. Acessar a pasta do projeto

```bash
cd menue
```

### 3. Instalar as dependências

```bash
flutter pub get
```

### 4. Verificar a instalação do Flutter

```bash
flutter doctor
```

### 5. Executar o aplicativo

Com um emulador iniciado ou dispositivo conectado, execute:

```bash
flutter run
```