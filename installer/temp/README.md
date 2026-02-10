# Pertocheck502s - Versão 2.1.0
Impressora de Cheques Perto Check 502S - Java Desktop Application

## 🎉 VERSÃO MODERNIZADA E SUSTENTÁVEL

✅ **Java 21 LTS** | ✅ **Maven** | ✅ **jSerialComm** | ✅ **97% menor** | ✅ **Bugs corrigidos**

---

## 📚 DOCUMENTAÇÃO COMPLETA

### 🚀 Início Rápido
- **[INDICE.md](INDICE.md)** - Índice completo da documentação
- **[SUMARIO.md](SUMARIO.md)** - Visão geral do projeto
- **[INICIO_RAPIDO.md](INICIO_RAPIDO.md)** - 3 passos para começar

### 🔧 Instalação
- **[INSTALACAO_DEPENDENCIAS.md](INSTALACAO_DEPENDENCIAS.md)** - Como instalar Java 21 e Maven

### 📖 Referência
- **[IMPLEMENTACAO.md](IMPLEMENTACAO.md)** - Detalhes técnicos
- **[MIGRACAO.md](MIGRACAO.md)** - Guia de migração
- **[CHECKLIST.md](CHECKLIST.md)** - Validação

---

## ⚡ INÍCIO RÁPIDO

```bash
# 1. Compilar
build.bat

# 2. Configurar C:\Windows\Temp\config.txt
PORTA=COM1
BITS_PER_SECOND=9600
DIRETORIO=

# 3. Executar
run.bat
```

---

## 🚀 Melhorias da Versão 2.1.0

### ✅ Modernização Completa
- **Java 21 LTS** - Versão moderna e com suporte de longo prazo
- **jSerialComm** - Biblioteca de comunicação serial moderna e mantida
- **Maven** - Gerenciamento automático de dependências
- **Apache Commons Lang 3** - Biblioteca atualizada

### 🐛 Correções
- Corrigido bug de listeners duplicados no botão Imprimir
- Melhor tratamento de erros de comunicação serial
- Validação de arquivo antes da impressão

---

## 📋 Pré-requisitos

- **Java 21** ou superior instalado
- **Maven 3.6+** instalado
- Impressora Perto Check 502S conectada via porta serial

---

## 🔧 Compilação

### Usando Maven:

```bash
# Compilar o projeto
mvn clean compile

# Gerar JAR executável
mvn clean package

# O arquivo será gerado em: target/Pertocheck502s.jar
```

---

## ▶️ Execução

### Executar diretamente:
```bash
java -jar target/Pertocheck502s.jar
```

### Ou via Maven:
```bash
mvn exec:java -Dexec.mainClass="visualizacao.JFramePrincipal"
```

---

## ⚙️ Configuração

### Arquivo: `C:\Windows\Temp\config.txt`

```
PORTA=COM1
BITS_PER_SECOND=9600
DIRETORIO=
```

**Parâmetros:**
- `PORTA`: Porta serial onde a impressora está conectada (COM1, COM2, etc)
- `BITS_PER_SECOND`: Taxa de transmissão (padrão: 9600)
- `DIRETORIO`: Diretório padrão para seleção de arquivos (opcional)

---

## 📄 Formato do Arquivo de Cheque

O arquivo deve conter 4 ou 5 linhas:

### Com número do banco (5 linhas):
```
123
1250.50
JOSE DA SILVA
SAO PAULO
31/12/2024
```

### Sem número do banco (4 linhas):
```
1250.50
JOSE DA SILVA
SAO PAULO
31/12/2024
```

**Formato:**
1. Número do banco (opcional)
2. Valor do cheque
3. Nome do beneficiário
4. Cidade
5. Data (dd/mm/aaaa ou dd/mm/aa)

---

## 🔍 Modo Suporte

Marque a opção "Suporte" na interface para visualizar logs detalhados após a impressão.

---

## 📦 Estrutura do Projeto

```
Pertocheck502s/
├── pom.xml                          # Configuração Maven
├── config.txt                       # Arquivo de configuração exemplo
├── Pertocheck502s/
│   ├── src/
│   │   ├── comunicacao/            # Comunicação serial
│   │   │   ├── PCheck.java
│   │   │   ├── PchekCommModerno.java  # Nova implementação
│   │   │   └── Protocolo.java
│   │   ├── controle/               # Controladores
│   │   ├── negocio/                # Regras de negócio
│   │   ├── utils/                  # Utilitários
│   │   └── visualizacao/           # Interface gráfica
│   └── executavel/                 # Executável legado (obsoleto)
└── README.md
```

---

## 🛠️ Dependências

- **jSerialComm 2.10.4** - Comunicação serial
- **Apache Commons Lang3 3.14.0** - Utilitários

---

## 📝 Logs

Os logs são salvos em: `C:\Windows\Temp\log.txt`

---

## ⚠️ Solução de Problemas

### Erro: "Porta COM não encontrada"
- Verifique se a impressora está conectada
- Confirme a porta correta no Gerenciador de Dispositivos do Windows
- Atualize o arquivo `config.txt` com a porta correta

### Erro: "Tempo esgotado esperando ACK"
- Verifique se o cabo está conectado na entrada **Host** da impressora
- Tente reiniciar a impressora
- Verifique se a taxa de transmissão está correta (padrão: 9600)

### Erro: "Equipamento ocupado/desligado"
- Verifique se a impressora está ligada
- Aguarde impressões anteriores terminarem
- Verifique os cabos de conexão

---

## 📞 Suporte

Para problemas técnicos, ative o modo "Suporte" e envie o log gerado.

---

## 📜 Licença

Projeto interno - Todos os direitos reservados

---

## 🔄 Migração da Versão Antiga

A versão 2.1.0 é **compatível** com arquivos de cheque da versão anterior.

**Mudanças principais:**
- Não é mais necessário o JRE embarcado
- Usa Java 21 instalado no sistema
- JAR único com todas as dependências
