# 📐 Documentação UML - App CRUD BLoC

## 🎯 Visão Geral

Este documento contém os diagramas UML completos da arquitetura do **App CRUD BLoC**, um template profissional de aplicação Flutter baseado em **Clean Architecture**, **BLoC Pattern**, **Drift ORM** e **GetIt DI**.

---

## 📊 Diagramas Disponíveis

### 1. Diagrama de Pacotes (Package Diagram)
**Arquivo:** `01_package_diagram.puml`

**Objetivo:** Mostrar a organização de alto nível do código em pacotes e suas dependências.

**Conteúdo:**
- Estrutura de pastas do projeto
- Camadas da Clean Architecture (Presentation, Logic, Data, Core)
- Dependências entre pacotes
- Bibliotecas externas utilizadas
- Code generation (Drift, L10n)

**Use quando:**
- Apresentar a arquitetura geral do projeto
- Explicar a separação de responsabilidades
- Documentar onboarding de novos desenvolvedores
- Revisão de arquitetura

---

### 2. Diagrama de Componentes (Component Diagram)
**Arquivo:** `02_component_diagram.puml`

**Objetivo:** Detalhar os componentes principais e o fluxo de dados entre eles.

**Conteúdo:**
- Componentes de UI (Screens, Widgets)
- Componentes de estado (BLoCs, Cubits)
- Repositórios e DAOs
- Database (SQLite/Drift)
- Sistemas de suporte (DI, Router, L10n)
- Fluxos de dados reativos (Streams)
- Event/State flow

**Use quando:**
- Explicar como os dados fluem pela aplicação
- Documentar integrações entre componentes
- Troubleshooting de problemas de fluxo de dados
- Planejamento de novas features

---

### 3. Diagrama de Classes (Class Diagram)
**Arquivo:** `03_class_diagram.puml`

**Objetivo:** Detalhar as classes principais, suas propriedades, métodos e relacionamentos.

**Conteúdo:**
- Models (Item, Product)
- Database classes (AppDatabase, DAOs)
- Repositories (ItemRepository, ProductRepository)
- BLoC classes (ItemBloc, CrudBloc<T>)
- Cubit classes (ItemListCubit, ProductListCubit)
- Events (sealed classes)
- States (sealed classes)
- DI Container (InjectionContainer)
- Router (AppRouter, RouteNames)
- Configuration (LocaleBloc, ThemeBloc, AppTheme)

**Use quando:**
- Documentar API de classes
- Entender relacionamentos entre objetos
- Planejar refatorações
- Code review
- Implementar novas features similares

---

### 4. Diagrama de Sequência (Sequence Diagram)
**Arquivo:** `04_sequence_diagram.puml`

**Objetivo:** Mostrar o fluxo temporal de operações CRUD completas.

**Conteúdo:**
- **Cenário 1:** Load Items (inicialização)
- **Cenário 2:** Create Item (criação)
- **Cenário 3:** Update Item (atualização)
- **Cenário 4:** Delete Item (exclusão)
- **Cenário 5:** Delete All Items (exclusão em massa)
- **Cenário 6:** Error Handling (tratamento de erros)

**Use quando:**
- Debugar problemas de fluxo
- Entender ordem de execução
- Documentar processos complexos
- Treinar novos desenvolvedores
- Testes de integração

---

## 🛠️ Como Usar os Diagramas

### Opção 1: PlantUML Online (Rápido)
1. Acesse http://www.plantuml.com/plantuml/uml/
2. Cole o conteúdo de qualquer arquivo `.puml`
3. Visualize o diagrama renderizado
4. Exporte como PNG/SVG/PDF

### Opção 2: VS Code Extension (Recomendado)
1. Instale a extensão: **PlantUML** (jebbs.plantuml)
2. Instale Java (requisito do PlantUML): https://www.java.com/
3. Abra o arquivo `.puml` no VS Code
4. Pressione `Alt + D` para preview
5. Clique com botão direito → "Export Current Diagram"

### Opção 3: Command Line (Profissional)
```bash
# Instalar PlantUML
# Via Homebrew (macOS)
brew install plantuml

# Via apt (Ubuntu/Debian)
sudo apt-get install plantuml

# Gerar PNG
plantuml 01_package_diagram.puml

# Gerar SVG (vetorial)
plantuml -tsvg 01_package_diagram.puml

# Gerar todos os diagramas
plantuml *.puml
```

### Opção 4: Integração com IDE
- **IntelliJ IDEA / Android Studio:** Plugin PlantUML Integration
- **Eclipse:** PlantUML Plugin
- **Atom:** PlantUML Viewer

---

## 📁 Estrutura de Arquivos de Documentação

```
docs/
├── uml/
│   ├── 01_package_diagram.puml          # Diagrama de Pacotes
│   ├── 02_component_diagram.puml        # Diagrama de Componentes
│   ├── 03_class_diagram.puml            # Diagrama de Classes
│   ├── 04_sequence_diagram.puml         # Diagrama de Sequência
│   └── README.md                        # Este arquivo
├── generated/
│   ├── 01_package_diagram.png
│   ├── 02_component_diagram.png
│   ├── 03_class_diagram.png
│   └── 04_sequence_diagram.png
└── architecture_guide.md                # Guia de arquitetura detalhado
```

---

## 🎨 Personalizando os Diagramas

### Mudar Tema
```plantuml
!theme blueprint        # Tema atual (azul profissional)
!theme cerulean        # Alternativa: azul claro
!theme plain           # Alternativa: minimalista
!theme carbon          # Alternativa: dark mode
```

### Mudar Cores
```plantuml
' Em qualquer diagrama, adicione:
skinparam packageBackgroundColor LightBlue
skinparam componentBackgroundColor LightGreen
skinparam classBackgroundColor LightYellow
```

### Adicionar Notas
```plantuml
note right of MyClass
  Esta é uma nota explicativa
  sobre MyClass
end note

note as N1
  Nota flutuante
end note
```

---

## 📚 Referências PlantUML

### Documentação Oficial
- **Site oficial:** https://plantuml.com/
- **Class Diagram:** https://plantuml.com/class-diagram
- **Component Diagram:** https://plantuml.com/component-diagram
- **Sequence Diagram:** https://plantuml.com/sequence-diagram
- **Package Diagram:** https://plantuml.com/component-diagram
- **Themes:** https://plantuml.com/theme

### Guias e Tutoriais
- **Real World PlantUML:** https://real-world-plantuml.com/
- **PlantUML CheatSheet:** https://ogom.github.io/draw_uml/plantuml/
- **VS Code Extension Guide:** https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml

---

## 🏗️ Princípios Arquiteturais Documentados

### Clean Architecture
Os diagramas refletem os seguintes princípios:

1. **Dependency Rule:** Dependências apontam sempre para dentro
   - Presentation → Logic → Data
   - Nunca Data → Logic ou Logic → Presentation

2. **Separation of Concerns:** Cada camada tem responsabilidade única
   - **Presentation:** UI e navegação
   - **Logic:** Regras de negócio e estado
   - **Data:** Persistência e acesso a dados

3. **Dependency Inversion:** Abstrações não dependem de detalhes
   - BLoCs dependem de Repository (interface)
   - Repository depende de DAO (abstração Drift)
   - DAO depende de Database (Drift)

### BLoC Pattern
Fluxo unidirecional documentado nos diagramas:

```
User Action → Event → BLoC → Repository → Database
                ↓
            State ← BLoC ← Stream ← Database
                ↓
            UI Update
```

### Design Patterns Utilizados
- **Repository Pattern:** Abstração de fonte de dados
- **Factory Pattern:** GetIt DI para criar instâncias
- **Singleton Pattern:** Database, Repositories
- **Observer Pattern:** Streams reativas
- **State Pattern:** BLoC states (sealed classes)
- **Command Pattern:** BLoC events (sealed classes)

---

## 🔄 Atualizando os Diagramas

### Quando Atualizar

**Adicionar nova entidade (ex: Order):**
1. Atualizar `01_package_diagram.puml` - Adicionar package `order`
2. Atualizar `02_component_diagram.puml` - Adicionar componentes OrderBloc, OrderRepository, etc
3. Atualizar `03_class_diagram.puml` - Adicionar classes Order, OrderEvent, OrderState, etc
4. Criar novo `05_sequence_diagram_order.puml` se necessário

**Mudar arquitetura:**
1. Atualizar todos os diagramas afetados
2. Adicionar notas explicando a mudança
3. Manter versão anterior para histórico (backup)

**Adicionar feature:**
1. Verificar se impacta arquitetura geral
2. Se sim, atualizar diagramas relevantes
3. Se não, documentar em comentários de código

### Versionamento
```
docs/uml/
├── v1.0/
│   ├── 01_package_diagram.puml
│   ├── 02_component_diagram.puml
│   └── ...
├── v1.1/  (após adicionar Products)
│   ├── 01_package_diagram.puml
│   ├── 02_component_diagram.puml
│   └── ...
└── current/  (symlink para versão atual)
```

---

## 📖 Leitura Recomendada

### Livros
- **Clean Architecture** - Robert C. Martin
- **Design Patterns** - Gang of Four
- **Domain-Driven Design** - Eric Evans

### Artigos
- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
- [BLoC Pattern Official](https://bloclibrary.dev/)
- [Drift Documentation](https://drift.simonbinder.eu/)

### Cursos
- Udemy: "Flutter & Dart - The Complete Guide"
- Udemy: "Clean Architecture in Flutter"
- YouTube: Reso Coder Flutter Tutorials

---

## 🤝 Contribuindo com a Documentação

### Adicionando Novos Diagramas

1. **Use a convenção de nomes:**
   - `XX_nome_do_diagrama.puml`
   - Onde XX é número sequencial (05, 06, etc)

2. **Inclua cabeçalho padrão:**
   ```plantuml
   @startuml app_crud_bloc_nome_diagram
   !theme blueprint
   title Título do Diagrama\nSubtítulo descritivo
   ```

3. **Adicione legendas e notas:**
   ```plantuml
   legend right
     Explicação das cores/símbolos
   end legend
   
   note as N1
     Informações importantes
   end note
   ```

4. **Documente no README:**
   - Adicione seção explicando o novo diagrama
   - Descreva quando usar
   - Liste conteúdo principal

### Revisão de Diagramas

**Checklist:**
- [ ] Diagrama renderiza sem erros
- [ ] Cores consistentes com outros diagramas
- [ ] Notas e legendas presentes
- [ ] Relacionamentos corretos
- [ ] Nomes de classes/componentes correspondem ao código
- [ ] README atualizado

---

## 🐛 Troubleshooting

### Diagrama não renderiza
```bash
# Verifique sintaxe
plantuml -syntax 01_package_diagram.puml

# Verifique instalação Java
java -version

# Reinstale PlantUML
brew reinstall plantuml
```

### Caracteres especiais quebrados
```plantuml
' Adicione no início do arquivo:
@startuml
skinparam defaultFontName Arial
@enduml
```

### Diagrama muito grande
```plantuml
' Adicione scale para reduzir
@startuml
scale 0.8
' ... resto do diagrama
@enduml
```

---

## 📊 Métricas da Arquitetura

### Camadas
- **Presentation:** ~15 arquivos
- **Logic:** ~20 arquivos (BLoCs, Events, States)
- **Data:** ~12 arquivos (Models, DAOs, Repositories)
- **Core:** ~8 arquivos (DI, Router, Theme)
- **Total:** ~55 arquivos de código

### Dependências
- **Externas:** 15+ packages
- **Código gerado:** 5+ arquivos (.g.dart)
- **Localização:** 3 idiomas (EN, PT, ES)

### Complexidade
- **Cyclomatic Complexity:** Baixa (BLoC simplifica fluxos)
- **Coupling:** Baixo (DI e Repository Pattern)
- **Cohesion:** Alto (SRP respeitado)

---

## ✅ Conclusão

Esta documentação UML serve como:
- 📘 **Guia de referência** para a arquitetura
- 🎓 **Material de onboarding** para novos desenvolvedores
- 🔍 **Ferramenta de debugging** para entender fluxos
- 📋 **Template** para projetos similares
- 🏆 **Showcase** de boas práticas Flutter

**Mantenha esta documentação atualizada!** Diagramas desatualizados são piores que nenhum diagrama.

---

**Última atualização:** Dezembro 2024
**Versão da arquitetura:** 1.0.0
**Autor:** Jhoni Eldor Schulz
