# 📱 Flutter CRUD Professional

> **Aplicação CRUD completa em Flutter com arquitetura production-ready**

Uma aplicação full-stack Flutter demonstrando Clean Architecture, BLoC pattern, Drift ORM, e internacionalização em 3 idiomas.

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.2+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 📸 Screenshots

```
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   Lista de      │  │   Detalhes      │  │   Formulário    │
│   Items         │  │   do Item       │  │   Criar/Editar  │
│                 │  │                 │  │                 │
│  • Item 1       │  │  Título: ...    │  │  [Título]       │
│  • Item 2       │  │  Descrição: ... │  │  [Descrição]    │
│  • Item 3       │  │  Criado: ...    │  │                 │
│                 │  │                 │  │  [Salvar]       │
│  [+ Adicionar]  │  │  [Editar] [Del] │  │  [Cancelar]     │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

---

## ✨ Features

### 🎯 Funcionalidades Core
- ✅ **CRUD Completo**: Create, Read, Update, Delete
- ✅ **Persistência Local**: SQLite via Drift ORM
- ✅ **Internacionalização**: Suporte para EN, PT, ES
- ✅ **Navigation Type-Safe**: GoRouter com rotas tipadas
- ✅ **Validação de Formulários**: Validações em tempo real
- ✅ **Empty States**: Estados vazios informativos
- ✅ **Error Handling**: Tratamento robusto de erros
- ✅ **Loading States**: Indicadores de carregamento

### 🎨 UX/UI
- ✅ **Material Design 3**: Interface moderna
- ✅ **Pull-to-Refresh**: Atualização manual da lista
- ✅ **Dialogs de Confirmação**: Confirmações para ações destrutivas
- ✅ **SnackBars**: Feedback imediato ao usuário
- ✅ **Master-Detail Navigation**: Navegação hierárquica
- ✅ **Formatação de Datas**: Por localidade

### 🏗️ Arquitetura
- ✅ **Clean Architecture**: 3 camadas bem definidas
- ✅ **BLoC Pattern**: Gerenciamento de estado com sealed classes
- ✅ **Dependency Injection**: GetIt para DI
- ✅ **Type-Safe**: 100% null-safety e type-safety
- ✅ **Code Generation**: Drift ORM com build_runner
- ✅ **Testável**: Arquitetura preparada para testes

---

## 🏛️ Arquitetura

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │ ItemList     │  │ ItemDetail   │  │ ItemForm     │  │
│  │ Screen       │  │ Screen       │  │ Screen       │  │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  │
│         │                 │                 │           │
│         └─────────────────┴─────────────────┘           │
│                           │                             │
└───────────────────────────┼─────────────────────────────┘
                            │
                   ┌────────▼────────┐
                   │   BLoC Pattern  │
                   │   (Events →     │
                   │    States)      │
                   └────────┬────────┘
                            │
┌───────────────────────────┼─────────────────────────────┐
│                      LOGIC LAYER                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │ ItemBloc     │  │ LocaleBloc   │  │ Events &     │  │
│  │              │  │              │  │ States       │  │
│  └──────┬───────┘  └──────────────┘  └──────────────┘  │
│         │                                               │
└─────────┼───────────────────────────────────────────────┘
          │
    ┌─────▼─────┐
    │ GetIt DI  │
    └─────┬─────┘
          │
┌─────────┼───────────────────────────────────────────────┐
│                      DATA LAYER                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │ Repository   │  │ ItemsDao     │  │ AppDatabase  │  │
│  │              │  │              │  │ (Drift ORM)  │  │
│  └──────────────┘  └──────────────┘  └──────┬───────┘  │
│                                              │           │
└──────────────────────────────────────────────┼───────────┘
                                               │
                                        ┌──────▼──────┐
                                        │   SQLite    │
                                        │   Database  │
                                        └─────────────┘
```

---

## 🚀 Quick Start

### Pré-requisitos

- Flutter SDK ≥ 3.24.0
- Dart SDK ≥ 3.2.0
- Android Studio / VS Code
- Git

### Instalação

```bash
# 1. Clone o repositório
git clone https://github.com/seu-usuario/flutter-crud-pro.git
cd flutter-crud-pro

# 2. Instale as dependências
flutter pub get

# 3. Gere os arquivos Drift
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Gere as localizações
flutter gen-l10n

# 5. Execute o app
flutter run
```

### Verificar Instalação

```bash
# Verificar ambiente
flutter doctor

# Analisar código
flutter analyze

# Executar testes (quando implementados)
flutter test
```

---

## 📦 Dependências Principais

### Production
```yaml
# State Management
bloc: ^9.1.0
flutter_bloc: ^9.1.0
equatable: ^2.0.5

# Database
drift: ^2.16.0
sqlite3_flutter_libs: ^0.5.20

# Dependency Injection
get_it: ^7.6.7

# Routing
go_router: ^14.0.0

# Storage
shared_preferences: ^2.2.3
```

### Development
```yaml
# Code Generation
build_runner: ^2.4.8
drift_dev: ^2.16.0

# Testing
bloc_test: ^9.1.7
mocktail: ^1.0.0
```

---

## 📁 Estrutura de Pastas

```
lib/
├── core/
│   ├── di/
│   │   └── injection_container.dart    # Configuração GetIt
│   └── routing/
│       ├── app_router.dart             # Configuração GoRouter
│       └── route_names.dart            # Constantes de rotas
├── data/
│   ├── database/
│   │   └── app_database.dart           # Configuração Drift
│   ├── daos/
│   │   └── items_dao.dart              # Data Access Object
│   ├── models/
│   │   └── item.dart                   # Definição da tabela
│   └── repositories/
│       └── item_repository.dart        # Camada de abstração
├── logic/
│   ├── item/
│   │   ├── item_bloc.dart              # Lógica de negócio
│   │   ├── item_event.dart             # Eventos (sealed)
│   │   └── item_state.dart             # Estados (sealed)
│   └── locale/
│       ├── locale_bloc.dart            # Gerenciamento de idioma
│       ├── locale_event.dart
│       └── locale_state.dart
├── presentation/
│   └── screens/
│       ├── item/
│       │   ├── item_list_screen.dart   # Tela principal
│       │   ├── item_detail_screen.dart # Detalhes
│       │   └── item_form_screen.dart   # Criar/Editar
│       └── settings/
│           └── settings_screen.dart    # Configurações
├── l10n/
│   ├── app_en.arb                      # Strings em Inglês
│   ├── app_pt.arb                      # Strings em Português
│   └── app_es.arb                      # Strings em Espanhol
└── main.dart                           # Entry point
```

---

## 🎯 Como Usar

### Criar Item

1. Clique no botão **"+"** (FAB)
2. Preencha título (mín. 3 caracteres)
3. Preencha descrição (mín. 10 caracteres)
4. Clique em **"Salvar"**

### Visualizar Item

- **Opção 1**: Clique no card do item
- **Opção 2**: Clique no ícone 👁️ (Visualizar)

### Editar Item

- **Opção 1**: No card, clique no ícone ✏️ (Editar)
- **Opção 2**: Na tela de detalhes, clique em **"Editar"**

### Deletar Item

- **Opção 1**: No card, clique no ícone 🗑️ (Deletar)
- **Opção 2**: Na tela de detalhes, clique em **"Deletar"**
- **Confirme** a ação no dialog

### Deletar Todos

1. Na lista, clique no ícone 🧹 (Sweep)
2. **Confirme** a exclusão em massa

### Trocar Idioma

1. Vá para **Configurações** (ícone ⚙️)
2. Clique em **"Selecionar Idioma"**
3. Escolha: English, Português ou Español
4. O app atualiza **instantaneamente**

### Pull-to-Refresh

- Na lista, **arraste para baixo** para recarregar

---

## 🧪 Testes

### Executar Todos os Testes

```bash
flutter test
```

### Testar Manualmente (Checklist)

#### CRUD
- [ ] Criar item com dados válidos
- [ ] Validações funcionam (campos vazios, tamanho mínimo)
- [ ] Visualizar item criado
- [ ] Editar item existente
- [ ] Deletar item individual
- [ ] Deletar todos os itens

#### Navegação
- [ ] FAB navega para formulário de criação
- [ ] Card navega para detalhes
- [ ] Botões Edit/View/Delete funcionam
- [ ] Voltar (back) funciona em todas as telas

#### Internacionalização
- [ ] Trocar para Português
- [ ] Trocar para Espanhol
- [ ] Trocar para Inglês
- [ ] Datas formatadas corretamente
- [ ] Idioma persiste após reiniciar app

#### Persistência
- [ ] Criar itens
- [ ] Fechar app (Ctrl+C)
- [ ] Reabrir app
- [ ] Itens ainda presentes ✅

---

## 🔧 Code Generation

### Regenerar Drift (após modificar models/daos)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Regenerar Localizações (após modificar ARB files)

```bash
flutter gen-l10n
```

### Watch Mode (desenvolvimento)

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## 🐛 Troubleshooting

### Build Runner não gera arquivos

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Erro de imports `.g.dart`

1. Verifique se o `part` está correto no arquivo
2. Execute build_runner
3. Faça `flutter clean` e `flutter pub get`

### Erro "The getter 'itemsDao' isn't defined"

Adicione no `app_database.dart`:
```dart
ItemsDao get itemsDao => ItemsDao(this);
```

### Erro "Invalid radix-10 number 'new'"

Ordem das rotas no `app_router.dart`:
```dart
// ✅ CORRETO:
GoRoute(path: '/item/new'),    // Específico primeiro
GoRoute(path: '/item/:id'),    // Genérico depois
```

### Database não persiste

Verifique o log do console para o caminho do banco:
```
📂 Database path: /path/to/app.db
```

---

## 🏗️ Build para Produção

### Android APK

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (Google Play)

```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS (requer macOS)

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
# Output: build/web/
```

---

## 📚 Conceitos Aprendidos

### Clean Architecture
- Separação de camadas (Presentation, Logic, Data)
- Dependency Rule (dependências apontam para dentro)
- Inversão de Dependências

### BLoC Pattern
- Events: Intenções do usuário
- States: Estado da aplicação
- BLoC: Lógica de negócio
- Sealed Classes: Pattern matching exhaustivo

### Drift ORM
- Type-safe queries
- Code generation
- Reactive streams (watch)
- Migrations

### Dependency Injection
- Singleton vs Factory
- Testabilidade
- Baixo acoplamento

### GoRouter
- Type-safe routing
- Deep linking
- Path parameters

---

## 🎓 Recursos de Aprendizado

### Documentação Oficial
- [Flutter Docs](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [BLoC Library](https://bloclibrary.dev)
- [Drift Documentation](https://drift.simonbinder.eu)
- [GetIt Package](https://pub.dev/packages/get_it)
- [GoRouter Package](https://pub.dev/packages/go_router)

### Tutoriais Relacionados
- Clean Architecture in Flutter
- BLoC Pattern Deep Dive
- Drift ORM Tutorial
- Flutter Internationalization

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### Boas Práticas
- Siga o guia de estilo do Dart
- Adicione testes para novas features
- Atualize a documentação
- Execute `flutter analyze` antes de commitar

---

## 📝 Próximas Features (Roadmap)

- [ ] Testes unitários e de integração
- [ ] Dark mode / Light mode
- [ ] Busca e filtros
- [ ] Categorias/tags para items
- [ ] Ordenação customizável
- [ ] Export/Import (JSON, CSV)
- [ ] Backup e restore
- [ ] Sincronização com API
- [ ] Autenticação de usuário
- [ ] Paginação da lista
- [ ] Animações e transições
- [ ] Suporte offline-first

---

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

---

## 👨‍💻 Autor

**Jhoni Eldor Schulz**
- Email: jhonieldorschulz@gmail.com

---

## 🙏 Agradecimentos

- Flutter Team pela excelente framework
- BLoC Library pelos patterns de state management
- Drift Team pelo ORM robusto
- Comunidade Flutter por todo suporte

---

## 📊 Status do Projeto

![Status](https://img.shields.io/badge/Status-Concluído-success)
![Version](https://img.shields.io/badge/Version-1.0.0-blue)
![Coverage](https://img.shields.io/badge/Coverage-Em%20Progresso-yellow)

**Última atualização:** Dezembro 2025

---

<p align="center">
  Feito com Habilidades Ninja modo Jiraya usando Flutter
</p>

<p align="center">
  ⭐ Se este projeto foi útil, considere dar uma estrela!
</p>