# Guia Rápido - Pertocheck502s

## 🚀 Execução Rápida

### Opção 1: Compilar e Rodar API (Tudo em um comando)
```cmd
build-and-run-api.bat
```

### Opção 2: Compilar e Rodar Separadamente
```cmd
# Compilar
build-fast.bat

# Rodar API
run-api.bat
```

### Opção 3: Interface Gráfica
```cmd
build-fast.bat
run.bat
```

---

## 📋 Scripts Disponíveis

| Script | Descrição |
|--------|-----------|
| `build-and-run-api.bat` | Compila e inicia API em um comando |
| `build-fast.bat` | Compilação rápida sem testes |
| `build.bat` | Compilação completa com logs |
| `run-api.bat` | Inicia API REST (porta 9090) |
| `run.bat` | Inicia interface gráfica |
| `listar-portas.bat` | Lista portas COM disponíveis |
| `diagnostico.bat` | Testa configuração do sistema |

---

## 🔧 Comandos Manuais

### Compilar
```cmd
mvn clean package -DskipTests
```

### Rodar API
```cmd
java -jar target\Pertocheck502s.jar --api 9090
```

### Rodar GUI
```cmd
java -jar target\Pertocheck502s.jar
```

### Listar Portas COM
```cmd
java -jar target\Pertocheck502s.jar --portas
```

### Ver Ajuda
```cmd
java -jar target\Pertocheck502s.jar --help
```

---

## 🌐 Endpoints da API

Após iniciar a API, acesse:

- **Status**: http://localhost:9090/api/status
- **Documentação**: http://localhost:9090/api/docs
- **Imprimir Cheque**: POST http://localhost:9090/api/cheque/imprimir

### Exemplo de Requisição
```bash
curl -X POST http://localhost:9090/api/cheque/imprimir ^
  -H "Content-Type: application/json" ^
  -d "{\"beneficiario\":\"JOSE DA SILVA\",\"cidade\":\"SAO PAULO\",\"data\":\"301117\",\"valor\":\"000000012555\",\"operacao\":\"2\"}"
```

---

## ⚙️ Configuração

Crie o arquivo `config.txt` na raiz do projeto:
```
COM1
9600
```

---

## 🐛 Solução de Problemas

### JAR não reconhecido após instalação
1. Execute `diagnostico.bat` para verificar o ambiente
2. Certifique-se que Java 21+ está instalado: `java -version`
3. Recompile: `build-fast.bat`
4. Teste: `java -jar target\Pertocheck502s.jar --help`

### Erro ao abrir porta COM
1. Liste portas disponíveis: `listar-portas.bat`
2. Verifique se a impressora está conectada
3. Atualize `config.txt` com a porta correta

### API não inicia
1. Verifique se a porta 9090 está livre
2. Use porta diferente: `java -jar target\Pertocheck502s.jar --api 8080`
3. Verifique firewall do Windows

---

## 📦 Requisitos

- Java 21 ou superior
- Maven 3.6+
- Windows 7 ou superior
- Impressora Perto Check 502S conectada via serial

---

## 📝 Notas

- O Maven Shade Plugin empacota todas as dependências no JAR
- O JAR gerado é standalone (não precisa de libs externas)
- Arquivo gerado: `target\Pertocheck502s.jar` (~10MB)
