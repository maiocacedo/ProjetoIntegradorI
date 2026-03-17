<div align="center">

# ⚔️ Cavaleiro dos Circuitos

### Um jogo educativo de plataforma sobre Lógica Digital

[![Godot Engine](https://img.shields.io/badge/Godot-4.4-blue?logo=godotengine&logoColor=white)](https://godotengine.org/)
[![Plataforma](https://img.shields.io/badge/Plataforma-Android%20%7C%20Windows-green?logo=android)](https://godotengine.org/)
[![Linguagem](https://img.shields.io/badge/Linguagem-GDScript-orange)](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
[![Licença](https://img.shields.io/badge/Licença-MIT-yellow)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Concluído-brightgreen)]()
[![Educacional](https://img.shields.io/badge/Uso-Educacional-purple)]()

> *"Neste reino, os sinais viajam como feitiços: ligados (1) ou desligados (0). Prepare sua mente... e que a lógica esteja com você!"*

</div>

---

## 📋 Índice

- [Sobre o Jogo](#-sobre-o-jogo)
- [Contexto Educacional](#-contexto-educacional)
- [Portas Lógicas no Jogo](#-portas-lógicas-no-jogo)
- [Mecânicas de Jogo](#️-mecânicas-de-jogo)
- [Sistema de Progressão e Recompensas](#-sistema-de-progressão-e-recompensas)
- [Aplicabilidade em Escolas Técnicas e Faculdades](#-aplicabilidade-em-escolas-técnicas-e-faculdades)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Tecnologias Utilizadas](#️-tecnologias-utilizadas)
- [Como Executar](#-como-executar)
- [Exportar para PC (Windows)](#-exportar-para-pc-windows)
- [Arquitetura Técnica](#-arquitetura-técnica)
- [Contribuidores](#-contribuidores)

---

## 🎮 Sobre o Jogo

**Cavaleiro dos Circuitos** é um jogo de plataforma 2D educativo desenvolvido com **Godot Engine 4.4**, cujo objetivo é ensinar os fundamentos de **portas lógicas digitais** de forma lúdica e interativa. O jogador assume o papel de um Cavaleiro que atravessa o mundo mágico da Lógica Digital, enfrentando desafios que representam o comportamento real de cada porta lógica.

O jogo foi desenvolvido como **Projeto Integrador** de curso, unindo conceitos de engenharia de software, game design e pedagogia ativa para criar uma ferramenta de ensino que vai além da lousa e do livro didático.

### 🎯 Proposta Central

Em vez de apresentar tabelas-verdade de forma abstrata, o jogo **traduz o comportamento de cada porta lógica em mecânicas jogáveis**. O jogador só consegue avançar de fase quando resolve o "problema lógico" daquela porta — seja coletando chaves, ativando alavancas ou evitando armadilhas sob as condições corretas.

---

## 📚 Contexto Educacional

### Por que um jogo sobre Portas Lógicas?

Portas lógicas são a base de toda a computação moderna. Estão presentes em disciplinas como:

- Arquitetura e Organização de Computadores
- Eletrônica Digital
- Sistemas Digitais
- Fundamentos de Computação
- Circuitos Lógicos

Apesar da importância fundamental do tema, o ensino tradicional frequentemente enfrenta dificuldades de engajamento dos alunos, especialmente na abstração entre teoria e aplicação prática. **Cavaleiro dos Circuitos** foi desenvolvido para ser um recurso complementar ao ensino formal, tornando o aprendizado mais visual, interativo e memorável.

### Teoria da Aprendizagem Ativa

O jogo se apoia no conceito de **aprendizagem ativa**, onde o aluno aprende fazendo. Ao invés de apenas ler sobre a porta AND, o aluno precisa coletar a chave **E** ativar a alavanca ao mesmo tempo para avançar — vivenciando na prática o comportamento "tudo ou nada" da porta.

Ao final de cada fase, uma **Tela de Conclusão** apresenta em linguagem acessível o conceito que o aluno acabou de experimentar, consolidando o aprendizado de forma narrativa.

---

## 🔌 Portas Lógicas no Jogo

Cada fase representa uma porta lógica específica, traduzida em mecânica de jogo:

| Fase | Porta Lógica | Representação no Jogo | Condição para Passar |
|------|-------------|----------------------|---------------------|
| 1 | **Tutorial** | Introdução ao mundo (sinais 0 e 1) | Chegar à saída |
| 2 | **PUSH (Buffer)** | O sinal passa sem modificação | Apenas 1 chave necessária |
| 3 | **NOT (Inversora)** | O contrário é verdadeiro | Lógica invertida das alavancas |
| 4 | **AND (E)** | Tudo ou nada | Chave **E** alavanca ativada |
| 5 | **OR (OU)** | Basta um | Chave **OU** alavanca ativada |
| 6 | **NAND (NÃO E)** | Rebelde: só bloqueia quando tudo está ligado | Qualquer combinação exceto as duas ao mesmo tempo |
| 7 | **XOR (OU Exclusivo)** | Um ou outro, nunca os dois | Chave **OU** alavanca, **mas não ambos** |
| 8 | **NOR (NÃO OU)** | Silêncio total | **Nenhuma** das condições pode estar ativa |
| 9 | **XNOR (NÃO OU Exclusivo)** | A porta dos iguais | As duas condições devem ser **iguais** |
| 10 | **Desafio Final** | Combinação de conceitos | Múltiplas condições combinadas |

### 💡 Exemplo Prático — Porta AND (Fase 4)

```
PORTA AND:  Saída = Entrada A AND Entrada B

No jogo:
  Entrada A = Chave coletada?  (Sim = 1 / Não = 0)
  Entrada B = Alavanca ativada? (Sim = 1 / Não = 0)

  A porta só abre quando: A = 1 E B = 1
  Tabela-verdade vivenciada:
  ┌───┬───┬────────┐
  │ A │ B │ Saída  │
  ├───┼───┼────────┤
  │ 0 │ 0 │   0    │  ← Bloqueado
  │ 0 │ 1 │   0    │  ← Bloqueado
  │ 1 │ 0 │   0    │  ← Bloqueado
  │ 1 │ 1 │   1    │  ← ABRIU! ✓
  └───┴───┴────────┘
```

---

## ⚔️ Mecânicas de Jogo

### Controles

| Ação | Teclado (PC) | Botão (Mobile) |
|------|-------------|----------------|
| Mover para esquerda | `A` | Botão ◀ |
| Mover para direita | `D` | Botão ▶ |
| Pular | `Espaço` | Botão ↑ |

### Movimentação Avançada

O personagem possui mecânicas de plataforma de qualidade profissional:

- **Duplo Pulo** — permite saltar uma segunda vez no ar
- **Coyote Time** (0,15s) — permite pular por um breve instante após sair de uma plataforma, tornando o controle mais responsivo
- **Jump Buffer** (0,1s) — registra o input de pulo antecipado, fazendo o personagem pular assim que tocar o chão
- **Knockback** — ao ser atingido e sobreviver (com escudo), o personagem é empurrado

### Armadilhas e Inimigos

| Elemento | Comportamento | Proteção Disponível |
|----------|--------------|---------------------|
| 🔥 **Fire Trap** | Fogo que alterna entre ligado/desligado | Escudo (Pergaminho) |
| 🌵 **Espinhos** | Morte instantânea ao toque | Escudo (Pergaminho) |
| 🌀 **Plataforma Instável** | Cai após o jogador pousar, reaparece em 3s | — |
| 👻 **Fantasma** | Patrulha, persegue e se esconde quando encarado | Faquinha / Escudo |

#### 🤖 Inteligência do Fantasma

O inimigo Fantasma possui uma **máquina de estados** com 4 comportamentos:

```
PATRULHANDO → (jogador na área e não olhando) → PERSEGUINDO
PERSEGUINDO → (jogador olha para o fantasma)  → ESCONDENDO
ESCONDENDO  → (jogador desvia o olhar)        → PERSEGUINDO
PERSEGUINDO → (jogador usa Faquinha)          → DERROTADO
```

### Itens Coletáveis

| Item | Efeito | Slot |
|------|--------|------|
| 🗝️ **Chave** | Abre portas de fase | Slot 3 (dedicado) |
| 🥤 **Refri Pulante** | +70 de força de pulo | Slot 0–2 |
| 👟 **Tênis Veloz** | +50 de velocidade de movimento | Slot 0–2 |
| 🛡️ **Escudo** | Absorve 1 golpe fatal | Slot 0–2 |
| 🗡️ **Faquinha** | Derrota 1 inimigo Fantasma | Slot 0–2 |

---

## ⭐ Sistema de Progressão e Recompensas

### Como Funcionam as Estrelas

Ao completar uma fase, o jogador recebe de 1 a 3 estrelas baseado no tempo gasto:

```
⭐⭐⭐  —  Concluído em até 60 segundos
⭐⭐    —  Concluído em até 120 segundos
⭐      —  Concluído (qualquer tempo)
```

O sistema salva automaticamente o **melhor tempo** de cada fase. Se o jogador refizer uma fase mais devagar, o recorde anterior é preservado.

### Economia de Estrelas — A Loja

As estrelas acumuladas funcionam como moeda para comprar **upgrades permanentes** na Loja:

| Upgrade | Custo | Efeito |
|---------|-------|--------|
| 👟 Tênis Veloz | 6 ⭐ | +50 velocidade |
| 🥤 Refri Pulante | 12 ⭐ | +70 força de pulo |
| 🛡️ Escudo (Pergaminho) | 18 ⭐ | Absorve 1 golpe fatal |
| 🗡️ Faquinha (Capa) | 22 ⭐ | Derrota 1 inimigo |

> **Regra estratégica:** O jogador pode ter no máximo **3 upgrades ativos simultaneamente**, forçando escolhas estratégicas baseadas no desafio de cada fase.

### Skins Cosméticas

Além dos upgrades funcionais, a loja oferece **skins cosméticas** para personalizar o personagem. As skins são compradas com estrelas e não afetam a jogabilidade.

### Persistência de Dados

Todo o progresso é salvo automaticamente em `user://progress.json`, incluindo:
- Tempo e estrelas de cada fase
- Upgrades comprados e ativos
- Skin selecionada

---

## 🏫 Aplicabilidade em Escolas Técnicas e Faculdades

### Público-Alvo

| Nível | Curso | Disciplinas Relacionadas |
|-------|-------|--------------------------|
| **Técnico** | Informática, Eletrônica, Mecatrônica | Eletrônica Digital, Sistemas Digitais |
| **Graduação** | Ciência da Computação, Eng. da Computação, Eng. Elétrica | Arquitetura de Computadores, Circuitos Lógicos |
| **Graduação** | Sistemas de Informação, ADS | Fundamentos de Hardware, Organização de Computadores |

### Como Usar em Sala de Aula

**Antes da aula teórica** — Como motivação e introdução ao tema:
> O professor apresenta o jogo e permite que os alunos joguem as primeiras fases (Tutorial, PUSH e NOT) antes da aula. Isso cria uma experiência prévia que facilita a absorção do conteúdo formal.

**Durante a aula** — Como recurso de exemplificação:
> Ao ensinar a porta AND, o professor pode projetar a Fase 4, mostrando ao vivo como o conceito "tudo ou nada" se traduz em uma barreira física. A Tela de Conclusão da fase pode ser usada como ponto de partida para discussão.

**Depois da aula** — Como exercício de fixação:
> Os alunos jogam as fases correspondentes ao conteúdo ensinado e respondem questões adicionais relacionando o comportamento do jogo com a tabela-verdade real da porta.

**Como atividade avaliativa:**
> O professor pode propor uma sequência de fases como "desafio da semana", avaliando a compreensão do aluno pela quantidade de estrelas conquistadas e pela capacidade de explicar a lógica de cada fase.

### Alinhamento com a BNCC e DCNs

O jogo apoia competências previstas nas Diretrizes Curriculares Nacionais para cursos de computação e eletrônica, especialmente no que tange à:

- Compreensão de sistemas digitais e sua lógica de funcionamento
- Raciocínio lógico e resolução de problemas
- Aplicação de conceitos teóricos em situações práticas

### Vantagens Pedagógicas

- ✅ **Aprendizagem ativa** — o aluno aprende fazendo, não apenas lendo
- ✅ **Feedback imediato** — o jogo informa o erro no momento em que ocorre
- ✅ **Progressão gradual** — os conceitos são introduzidos do mais simples ao mais complexo
- ✅ **Contextualização narrativa** — cada conceito é explicado em linguagem acessível na Tela de Conclusão
- ✅ **Engajamento** — o sistema de estrelas e upgrades cria motivação intrínseca para repetir as fases
- ✅ **Sem barreiras de instalação** — disponível para Android e Windows
- ✅ **Offline** — não requer conexão com a internet

### Limitações Conhecidas

- Não apresenta tabelas-verdade explícitas (podem ser trabalhadas pelo professor como complemento)
- Não cobre circuitos combinacionais complexos (mais de 2 entradas)
- Ausência de narração em áudio (depende da leitura dos textos)

---

## 📁 Estrutura do Projeto

```
projeto-integrador-i-caiomacedo-completo/
│
├── Assets/                          # Recursos visuais e sonoros
│   ├── Items/                       # Ícones dos itens
│   ├── Inventory/                   # Interface do inventário
│   ├── music/                       # Trilhas sonoras (*.wav)
│   ├── sounds/                      # Efeitos sonoros (*.wav)
│   └── sprites/                     # Sprites e animações
│
├── Cenas/                           # Cenas do Godot (*.tscn)
│   ├── Items/                       # Cenas dos itens coletáveis
│   ├── alavanca/                    # Cena das alavancas
│   ├── armadilhas/                  # Cenas das armadilhas (fogo, espinhos, fantasma)
│   ├── fases/                       # 10 fases jogáveis
│   ├── hud e menus/                 # Interface, menus e HUD
│   ├── inventory/                   # Interface do inventário
│   ├── managers/                    # Cenas dos managers (autoloads)
│   ├── placa/                       # Cenas das sinalizações
│   ├── plataforma/                  # Cenas de plataformas especiais
│   └── player/                      # Cena do personagem jogável
│
├── Scripts/                         # Scripts GDScript (*.gd)
│   ├── Items/                       # Lógica dos itens (ItemDatabase)
│   ├── alavanca/                    # Lógica das alavancas
│   ├── armadilhas/                  # IA das armadilhas e inimigos
│   ├── fases/                       # Lógica de cada fase (portas lógicas)
│   ├── hud e menus/                 # Lógica dos menus e HUD
│   ├── inventory/                   # Gerenciamento do inventário
│   ├── managers/                    # GameManager, MusicManager, SaveManager, PlayerData
│   ├── placa/                       # Lógica das sinalizações
│   ├── player/                      # Controle do personagem
│   └── upgrades/                    # Lógica dos upgrades
│
├── project.godot                    # Configuração do projeto Godot
├── export_presets.cfg               # Configurações de exportação (Android/Windows)
└── README.md                        # Este arquivo
```

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Versão | Uso |
|------------|--------|-----|
| [Godot Engine](https://godotengine.org/) | 4.4 | Engine principal de desenvolvimento |
| GDScript | — | Linguagem de programação dos scripts |
| JSON | — | Formato de salvamento do progresso |
| Android Export | — | Build para dispositivos Android (APK) |
| Windows Export | — | Build para Windows Desktop (EXE) |

---

## ▶️ Como Executar

### Pré-requisitos

- [Godot Engine 4.4](https://godotengine.org/download) instalado

### Rodando pelo Editor

```bash
# 1. Clone o repositório
git clone https://github.com/seu-usuario/cavaleiro-dos-circuitos.git

# 2. Abra o Godot Engine 4.4

# 3. Clique em "Import" e selecione o arquivo project.godot

# 4. Pressione F5 ou clique no botão ▶ para executar
```

### Controles no PC

| Tecla | Ação |
|-------|------|
| `A` | Mover para esquerda |
| `D` | Mover para direita |
| `Espaço` | Pular (pressione duas vezes para duplo pulo) |

---

## 📦 Exportar para PC (Windows)

1. No Godot, vá em **Project → Export**
2. Selecione o preset **"Windows Desktop"**
3. Clique em **Export Project**
4. Salve como `Cavaleiro-dos-Circuitos.exe`
5. O arquivo `.pck` será gerado junto — **mantenha os dois arquivos na mesma pasta**

> 💡 **Dica:** Marque a opção **"Embed PCK"** para gerar um único `.exe` independente, mais fácil de distribuir.

---

## 🏗️ Arquitetura Técnica

### Singletons (Autoloads)

O projeto utiliza o padrão de **Managers como Singletons** do Godot, acessíveis globalmente em todas as cenas:

| Singleton | Responsabilidade |
|-----------|-----------------|
| `GameManager` | Transições de cena e tela de morte |
| `MusicManager` | Troca automática de música por cena |
| `SaveManager` | Leitura e escrita do progresso em JSON |
| `PlayerData` | Estatísticas e estado global do jogador |
| `ItemDB` | Banco de dados dos itens do jogo |

### Sistema de Save

```gdscript
# Arquivo salvo em: user://progress.json
# No Windows: C:\Users\[usuario]\AppData\Roaming\Godot\app_userdata\[projeto]\

{
  "fases": {
    "fase_1": { "tempo": 45.3, "estrelas": 3 }
  },
  "itens": {
    "shoes":      { "has": true, "purchased": true },
    "cape":       { "has": false, "purchased": false }
  },
  "skins": {
    "default": { "inuse": true, "purchased": true }
  }
}
```

### Lógica das Portas (Exemplo — XOR)

```gdscript
# Scripts/fases/fase_7.gd — Implementação da porta XOR
var tem_chave = qtdChaves == chavesNecessarias
var tem_alavanca = alavancas_ativadas == alavancasNecessarias

# XOR: verdadeiro apenas quando os valores são diferentes
if tem_chave == tem_alavanca:
    # Bloqueia — ambos iguais (0,0 ou 1,1)
    hud.show_message("Você precisa ter APENAS a chave OU APENAS a alavanca!")
    return

# Libera — valores diferentes (0,1 ou 1,0)
completed = true
```

---

## 👥 Contribuidores

| Nome | Papel |
|------|-------|
| **Caio Macedo** | Líder de projeto & Audio Designer |
| **Gustavo Mazur** | Líder de projeto & Level Designer |
| **Igor Carvalho** | Desenvolvimento de inimigos e armadilhas |
| **Bruno Alcantara** | Desenvolvimento do inventário e itens |
| **Ian Batista** | Desenvolvimento dos upgrades |
| **Jefferson Korte** | Desenvolvimento da movimentação do personagem |
| **Gabriel Dupim** | Design de sprites e arte |
| **Agnaldo da Costa** | Orientador |

---

## 📄 Licença

Este projeto foi desenvolvido para fins educacionais como **Projeto Integrador** de curso. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes sobre os termos de uso.

---

<div align="center">

Desenvolvido com ❤️ e muita lógica digital.

*"Que a lógica esteja com você!"*

</div><div align="center">

# ⚔️ Cavaleiro dos Circuitos

### Um jogo educativo de plataforma sobre Lógica Digital

[![Godot Engine](https://img.shields.io/badge/Godot-4.4-blue?logo=godotengine&logoColor=white)](https://godotengine.org/)
[![Plataforma](https://img.shields.io/badge/Plataforma-Android%20%7C%20Windows-green?logo=android)](https://godotengine.org/)
[![Linguagem](https://img.shields.io/badge/Linguagem-GDScript-orange)](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
[![Licença](https://img.shields.io/badge/Licença-MIT-yellow)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Concluído-brightgreen)]()
[![Educacional](https://img.shields.io/badge/Uso-Educacional-purple)]()

> *"Neste reino, os sinais viajam como feitiços: ligados (1) ou desligados (0). Prepare sua mente... e que a lógica esteja com você!"*

</div>

---

## 📋 Índice

- [Sobre o Jogo](#-sobre-o-jogo)
- [Contexto Educacional](#-contexto-educacional)
- [Portas Lógicas no Jogo](#-portas-lógicas-no-jogo)
- [Mecânicas de Jogo](#️-mecânicas-de-jogo)
- [Sistema de Progressão e Recompensas](#-sistema-de-progressão-e-recompensas)
- [Aplicabilidade em Escolas Técnicas e Faculdades](#-aplicabilidade-em-escolas-técnicas-e-faculdades)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Tecnologias Utilizadas](#️-tecnologias-utilizadas)
- [Como Executar](#-como-executar)
- [Exportar para PC (Windows)](#-exportar-para-pc-windows)
- [Arquitetura Técnica](#-arquitetura-técnica)
- [Contribuidores](#-contribuidores)

---

## 🎮 Sobre o Jogo

**Cavaleiro dos Circuitos** é um jogo de plataforma 2D educativo desenvolvido com **Godot Engine 4.4**, cujo objetivo é ensinar os fundamentos de **portas lógicas digitais** de forma lúdica e interativa. O jogador assume o papel de um Cavaleiro que atravessa o mundo mágico da Lógica Digital, enfrentando desafios que representam o comportamento real de cada porta lógica.

O jogo foi desenvolvido como **Projeto Integrador** de curso, unindo conceitos de engenharia de software, game design e pedagogia ativa para criar uma ferramenta de ensino que vai além da lousa e do livro didático.

### 🎯 Proposta Central

Em vez de apresentar tabelas-verdade de forma abstrata, o jogo **traduz o comportamento de cada porta lógica em mecânicas jogáveis**. O jogador só consegue avançar de fase quando resolve o "problema lógico" daquela porta — seja coletando chaves, ativando alavancas ou evitando armadilhas sob as condições corretas.

---

## 📚 Contexto Educacional

### Por que um jogo sobre Portas Lógicas?

Portas lógicas são a base de toda a computação moderna. Estão presentes em disciplinas como:

- Arquitetura e Organização de Computadores
- Eletrônica Digital
- Sistemas Digitais
- Fundamentos de Computação
- Circuitos Lógicos

Apesar da importância fundamental do tema, o ensino tradicional frequentemente enfrenta dificuldades de engajamento dos alunos, especialmente na abstração entre teoria e aplicação prática. **Cavaleiro dos Circuitos** foi desenvolvido para ser um recurso complementar ao ensino formal, tornando o aprendizado mais visual, interativo e memorável.

### Teoria da Aprendizagem Ativa

O jogo se apoia no conceito de **aprendizagem ativa**, onde o aluno aprende fazendo. Ao invés de apenas ler sobre a porta AND, o aluno precisa coletar a chave **E** ativar a alavanca ao mesmo tempo para avançar — vivenciando na prática o comportamento "tudo ou nada" da porta.

Ao final de cada fase, uma **Tela de Conclusão** apresenta em linguagem acessível o conceito que o aluno acabou de experimentar, consolidando o aprendizado de forma narrativa.

---

## 🔌 Portas Lógicas no Jogo

Cada fase representa uma porta lógica específica, traduzida em mecânica de jogo:

| Fase | Porta Lógica | Representação no Jogo | Condição para Passar |
|------|-------------|----------------------|---------------------|
| 1 | **Tutorial** | Introdução ao mundo (sinais 0 e 1) | Chegar à saída |
| 2 | **PUSH (Buffer)** | O sinal passa sem modificação | Apenas 1 chave necessária |
| 3 | **NOT (Inversora)** | O contrário é verdadeiro | Lógica invertida das alavancas |
| 4 | **AND (E)** | Tudo ou nada | Chave **E** alavanca ativada |
| 5 | **OR (OU)** | Basta um | Chave **OU** alavanca ativada |
| 6 | **NAND (NÃO E)** | Rebelde: só bloqueia quando tudo está ligado | Qualquer combinação exceto as duas ao mesmo tempo |
| 7 | **XOR (OU Exclusivo)** | Um ou outro, nunca os dois | Chave **OU** alavanca, **mas não ambos** |
| 8 | **NOR (NÃO OU)** | Silêncio total | **Nenhuma** das condições pode estar ativa |
| 9 | **XNOR (NÃO OU Exclusivo)** | A porta dos iguais | As duas condições devem ser **iguais** |
| 10 | **Desafio Final** | Combinação de conceitos | Múltiplas condições combinadas |

### 💡 Exemplo Prático — Porta AND (Fase 4)

```
PORTA AND:  Saída = Entrada A AND Entrada B

No jogo:
  Entrada A = Chave coletada?  (Sim = 1 / Não = 0)
  Entrada B = Alavanca ativada? (Sim = 1 / Não = 0)

  A porta só abre quando: A = 1 E B = 1
  Tabela-verdade vivenciada:
  ┌───┬───┬────────┐
  │ A │ B │ Saída  │
  ├───┼───┼────────┤
  │ 0 │ 0 │   0    │  ← Bloqueado
  │ 0 │ 1 │   0    │  ← Bloqueado
  │ 1 │ 0 │   0    │  ← Bloqueado
  │ 1 │ 1 │   1    │  ← ABRIU! ✓
  └───┴───┴────────┘
```

---

## ⚔️ Mecânicas de Jogo

### Controles

| Ação | Teclado (PC) | Botão (Mobile) |
|------|-------------|----------------|
| Mover para esquerda | `A` | Botão ◀ |
| Mover para direita | `D` | Botão ▶ |
| Pular | `Espaço` | Botão ↑ |

### Movimentação Avançada

O personagem possui mecânicas de plataforma de qualidade profissional:

- **Duplo Pulo** — permite saltar uma segunda vez no ar
- **Coyote Time** (0,15s) — permite pular por um breve instante após sair de uma plataforma, tornando o controle mais responsivo
- **Jump Buffer** (0,1s) — registra o input de pulo antecipado, fazendo o personagem pular assim que tocar o chão
- **Knockback** — ao ser atingido e sobreviver (com escudo), o personagem é empurrado

### Armadilhas e Inimigos

| Elemento | Comportamento | Proteção Disponível |
|----------|--------------|---------------------|
| 🔥 **Fire Trap** | Fogo que alterna entre ligado/desligado | Escudo (Pergaminho) |
| 🌵 **Espinhos** | Morte instantânea ao toque | Escudo (Pergaminho) |
| 🌀 **Plataforma Instável** | Cai após o jogador pousar, reaparece em 3s | — |
| 👻 **Fantasma** | Patrulha, persegue e se esconde quando encarado | Faquinha / Escudo |

#### 🤖 Inteligência do Fantasma

O inimigo Fantasma possui uma **máquina de estados** com 4 comportamentos:

```
PATRULHANDO → (jogador na área e não olhando) → PERSEGUINDO
PERSEGUINDO → (jogador olha para o fantasma)  → ESCONDENDO
ESCONDENDO  → (jogador desvia o olhar)        → PERSEGUINDO
PERSEGUINDO → (jogador usa Faquinha)          → DERROTADO
```

### Itens Coletáveis

| Item | Efeito | Slot |
|------|--------|------|
| 🗝️ **Chave** | Abre portas de fase | Slot 3 (dedicado) |
| 🥤 **Refri Pulante** | +70 de força de pulo | Slot 0–2 |
| 👟 **Tênis Veloz** | +50 de velocidade de movimento | Slot 0–2 |
| 🛡️ **Escudo** | Absorve 1 golpe fatal | Slot 0–2 |
| 🗡️ **Faquinha** | Derrota 1 inimigo Fantasma | Slot 0–2 |

---

## ⭐ Sistema de Progressão e Recompensas

### Como Funcionam as Estrelas

Ao completar uma fase, o jogador recebe de 1 a 3 estrelas baseado no tempo gasto:

```
⭐⭐⭐  —  Concluído em até 60 segundos
⭐⭐    —  Concluído em até 120 segundos
⭐      —  Concluído (qualquer tempo)
```

O sistema salva automaticamente o **melhor tempo** de cada fase. Se o jogador refizer uma fase mais devagar, o recorde anterior é preservado.

### Economia de Estrelas — A Loja

As estrelas acumuladas funcionam como moeda para comprar **upgrades permanentes** na Loja:

| Upgrade | Custo | Efeito |
|---------|-------|--------|
| 👟 Tênis Veloz | 6 ⭐ | +50 velocidade |
| 🥤 Refri Pulante | 12 ⭐ | +70 força de pulo |
| 🛡️ Escudo (Pergaminho) | 18 ⭐ | Absorve 1 golpe fatal |
| 🗡️ Faquinha (Capa) | 22 ⭐ | Derrota 1 inimigo |

> **Regra estratégica:** O jogador pode ter no máximo **3 upgrades ativos simultaneamente**, forçando escolhas estratégicas baseadas no desafio de cada fase.

### Skins Cosméticas

Além dos upgrades funcionais, a loja oferece **skins cosméticas** para personalizar o personagem. As skins são compradas com estrelas e não afetam a jogabilidade.

### Persistência de Dados

Todo o progresso é salvo automaticamente em `user://progress.json`, incluindo:
- Tempo e estrelas de cada fase
- Upgrades comprados e ativos
- Skin selecionada

---

## 🏫 Aplicabilidade em Escolas Técnicas e Faculdades

### Público-Alvo

| Nível | Curso | Disciplinas Relacionadas |
|-------|-------|--------------------------|
| **Técnico** | Informática, Eletrônica, Mecatrônica | Eletrônica Digital, Sistemas Digitais |
| **Graduação** | Ciência da Computação, Eng. da Computação, Eng. Elétrica | Arquitetura de Computadores, Circuitos Lógicos |
| **Graduação** | Sistemas de Informação, ADS | Fundamentos de Hardware, Organização de Computadores |

### Como Usar em Sala de Aula

**Antes da aula teórica** — Como motivação e introdução ao tema:
> O professor apresenta o jogo e permite que os alunos joguem as primeiras fases (Tutorial, PUSH e NOT) antes da aula. Isso cria uma experiência prévia que facilita a absorção do conteúdo formal.

**Durante a aula** — Como recurso de exemplificação:
> Ao ensinar a porta AND, o professor pode projetar a Fase 4, mostrando ao vivo como o conceito "tudo ou nada" se traduz em uma barreira física. A Tela de Conclusão da fase pode ser usada como ponto de partida para discussão.

**Depois da aula** — Como exercício de fixação:
> Os alunos jogam as fases correspondentes ao conteúdo ensinado e respondem questões adicionais relacionando o comportamento do jogo com a tabela-verdade real da porta.

**Como atividade avaliativa:**
> O professor pode propor uma sequência de fases como "desafio da semana", avaliando a compreensão do aluno pela quantidade de estrelas conquistadas e pela capacidade de explicar a lógica de cada fase.

### Alinhamento com a BNCC e DCNs

O jogo apoia competências previstas nas Diretrizes Curriculares Nacionais para cursos de computação e eletrônica, especialmente no que tange à:

- Compreensão de sistemas digitais e sua lógica de funcionamento
- Raciocínio lógico e resolução de problemas
- Aplicação de conceitos teóricos em situações práticas

### Vantagens Pedagógicas

- ✅ **Aprendizagem ativa** — o aluno aprende fazendo, não apenas lendo
- ✅ **Feedback imediato** — o jogo informa o erro no momento em que ocorre
- ✅ **Progressão gradual** — os conceitos são introduzidos do mais simples ao mais complexo
- ✅ **Contextualização narrativa** — cada conceito é explicado em linguagem acessível na Tela de Conclusão
- ✅ **Engajamento** — o sistema de estrelas e upgrades cria motivação intrínseca para repetir as fases
- ✅ **Sem barreiras de instalação** — disponível para Android e Windows
- ✅ **Offline** — não requer conexão com a internet

### Limitações Conhecidas

- Não apresenta tabelas-verdade explícitas (podem ser trabalhadas pelo professor como complemento)
- Não cobre circuitos combinacionais complexos (mais de 2 entradas)
- Ausência de narração em áudio (depende da leitura dos textos)

---

## 📁 Estrutura do Projeto

```
projeto-integrador-i-caiomacedo-completo/
│
├── Assets/                          # Recursos visuais e sonoros
│   ├── Items/                       # Ícones dos itens
│   ├── Inventory/                   # Interface do inventário
│   ├── music/                       # Trilhas sonoras (*.wav)
│   ├── sounds/                      # Efeitos sonoros (*.wav)
│   └── sprites/                     # Sprites e animações
│
├── Cenas/                           # Cenas do Godot (*.tscn)
│   ├── Items/                       # Cenas dos itens coletáveis
│   ├── alavanca/                    # Cena das alavancas
│   ├── armadilhas/                  # Cenas das armadilhas (fogo, espinhos, fantasma)
│   ├── fases/                       # 10 fases jogáveis
│   ├── hud e menus/                 # Interface, menus e HUD
│   ├── inventory/                   # Interface do inventário
│   ├── managers/                    # Cenas dos managers (autoloads)
│   ├── placa/                       # Cenas das sinalizações
│   ├── plataforma/                  # Cenas de plataformas especiais
│   └── player/                      # Cena do personagem jogável
│
├── Scripts/                         # Scripts GDScript (*.gd)
│   ├── Items/                       # Lógica dos itens (ItemDatabase)
│   ├── alavanca/                    # Lógica das alavancas
│   ├── armadilhas/                  # IA das armadilhas e inimigos
│   ├── fases/                       # Lógica de cada fase (portas lógicas)
│   ├── hud e menus/                 # Lógica dos menus e HUD
│   ├── inventory/                   # Gerenciamento do inventário
│   ├── managers/                    # GameManager, MusicManager, SaveManager, PlayerData
│   ├── placa/                       # Lógica das sinalizações
│   ├── player/                      # Controle do personagem
│   └── upgrades/                    # Lógica dos upgrades
│
├── project.godot                    # Configuração do projeto Godot
├── export_presets.cfg               # Configurações de exportação (Android/Windows)
└── README.md                        # Este arquivo
```

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Versão | Uso |
|------------|--------|-----|
| [Godot Engine](https://godotengine.org/) | 4.4 | Engine principal de desenvolvimento |
| GDScript | — | Linguagem de programação dos scripts |
| JSON | — | Formato de salvamento do progresso |
| Android Export | — | Build para dispositivos Android (APK) |
| Windows Export | — | Build para Windows Desktop (EXE) |

---

## ▶️ Como Executar

### Pré-requisitos

- [Godot Engine 4.4](https://godotengine.org/download) instalado

### Rodando pelo Editor

```bash
# 1. Clone o repositório
git clone https://github.com/seu-usuario/cavaleiro-dos-circuitos.git

# 2. Abra o Godot Engine 4.4

# 3. Clique em "Import" e selecione o arquivo project.godot

# 4. Pressione F5 ou clique no botão ▶ para executar
```

### Controles no PC

| Tecla | Ação |
|-------|------|
| `A` | Mover para esquerda |
| `D` | Mover para direita |
| `Espaço` | Pular (pressione duas vezes para duplo pulo) |

---

## 📦 Exportar para PC (Windows)

1. No Godot, vá em **Project → Export**
2. Selecione o preset **"Windows Desktop"**
3. Clique em **Export Project**
4. Salve como `Cavaleiro-dos-Circuitos.exe`
5. O arquivo `.pck` será gerado junto — **mantenha os dois arquivos na mesma pasta**

> 💡 **Dica:** Marque a opção **"Embed PCK"** para gerar um único `.exe` independente, mais fácil de distribuir.

---

## 🏗️ Arquitetura Técnica

### Singletons (Autoloads)

O projeto utiliza o padrão de **Managers como Singletons** do Godot, acessíveis globalmente em todas as cenas:

| Singleton | Responsabilidade |
|-----------|-----------------|
| `GameManager` | Transições de cena e tela de morte |
| `MusicManager` | Troca automática de música por cena |
| `SaveManager` | Leitura e escrita do progresso em JSON |
| `PlayerData` | Estatísticas e estado global do jogador |
| `ItemDB` | Banco de dados dos itens do jogo |

### Sistema de Save

```gdscript
# Arquivo salvo em: user://progress.json
# No Windows: C:\Users\[usuario]\AppData\Roaming\Godot\app_userdata\[projeto]\

{
  "fases": {
    "fase_1": { "tempo": 45.3, "estrelas": 3 }
  },
  "itens": {
    "shoes":      { "has": true, "purchased": true },
    "cape":       { "has": false, "purchased": false }
  },
  "skins": {
    "default": { "inuse": true, "purchased": true }
  }
}
```

### Lógica das Portas (Exemplo — XOR)

```gdscript
# Scripts/fases/fase_7.gd — Implementação da porta XOR
var tem_chave = qtdChaves == chavesNecessarias
var tem_alavanca = alavancas_ativadas == alavancasNecessarias

# XOR: verdadeiro apenas quando os valores são diferentes
if tem_chave == tem_alavanca:
    # Bloqueia — ambos iguais (0,0 ou 1,1)
    hud.show_message("Você precisa ter APENAS a chave OU APENAS a alavanca!")
    return

# Libera — valores diferentes (0,1 ou 1,0)
completed = true
```

---

## 👥 Contribuidores

| Nome | Papel |
|------|-------|
| **Caio Macedo** | Desenvolvedor principal — design, código e level design |

---

## 📄 Licença

Este projeto foi desenvolvido para fins educacionais como **Projeto Integrador** de curso. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes sobre os termos de uso.

---

<div align="center">

Desenvolvido com ❤️ e muita lógica digital.

*"Que a lógica esteja com você!"*

</div>
