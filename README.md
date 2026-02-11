# Pertocheck502s - Impressora de Cheques

Sistema para impressão de cheques usando impressora Perto Check 502S via comunicação serial.

## 🚀 Início Rápido

### Pré-requisitos
- Java 21 ou superior
- Maven 3.6+
- Windows 7 ou superior
- Impressora Perto Check 502S conectada via serial

### Instalação

1. Clone o repositório:
```bash
git clone <seu-repositorio>
cd Pertocheck502s
```

2. Configure a porta serial no `config.txt`:
```
PORTA=COM4
BITS_PER_SECOND=2400
```

3. Compile o projeto:
```cmd
rebuild.bat
```

4. Execute:
```cmd
run-api.bat
```

## 📋 Modos de Execução

### API REST (Recomendado)
```cmd
run-api.bat
```
Inicia servidor REST na porta 9090

### Interface Gráfica
```cmd
run.bat
```

### Listar Portas COM
```cmd
listar-portas.bat
```

## 🌐 API REST

### Endpoints

#### Status
```bash
GET http://localhost:9090/api/status
```

#### Imprimir Cheque
```bash
POST http://localhost:9090/api/cheque/imprimir
Content-Type: application/json

{
  "beneficiario": "JOSE DA SILVA",
  "cidade": "SAO PAULO",
  "data": "301117",
  "valor": "000000012555",
  "operacao": "2"
}
```

### Exemplo com cURL
```bash
curl -X POST http://localhost:9090/api/cheque/imprimir ^
  -H "Content-Type: application/json" ^
  -d "{\"beneficiario\":\"JOSE DA SILVA\",\"cidade\":\"SAO PAULO\",\"data\":\"301117\",\"valor\":\"000000012555\",\"operacao\":\"2\"}"
```

## ⚙️ Configuração

### config.txt
```
# Porta Serial
PORTA=COM4

# Taxa de transmissão (2400, 9600, 19200, etc)
BITS_PER_SECOND=2400

# Diretório padrão (opcional)
DIRETORIO=
```

## 🏗️ Estrutura do Projeto

```
Pertocheck502s/
├── src/
│   ├── api/              # API REST
│   ├── comunicacao/      # Comunicação serial
│   ├── controle/         # Controladores
│   ├── negocio/          # Regras de negócio
│   ├── utils/            # Utilitários
│   └── visualizacao/     # Interface gráfica
├── config.txt            # Configurações
├── pom.xml              # Maven
└── *.bat                # Scripts de execução
```

## 🔧 Scripts Disponíveis

| Script | Descrição |
|--------|-----------|
| `rebuild.bat` | Build completo do projeto |
| `run-api.bat` | Inicia API REST |
| `run.bat` | Inicia interface gráfica |
| `listar-portas.bat` | Lista portas COM disponíveis |
| `build-and-run-api.bat` | Build + execução da API |

## 📡 Comunicação Serial

O sistema usa comunicação serial RS-232 com protocolo:
- **STX** (0x02): Início
- **Comando**: Dados do cheque
- **ETX** (0x03): Fim
- **BCC**: Checksum (XOR)

### Comandos da Impressora
- `%NOME` - Beneficiário
- `#CIDADE` - Cidade
- `!DATA` - Data (ddmmaa)
- `;VALOR` - Valor + operação
- `>` - Ejetar cheque

## 🐛 Solução de Problemas

### Porta não encontrada
```cmd
listar-portas.bat
```
Verifique a porta correta e atualize `config.txt`

### Erro de compilação
Verifique se Maven está instalado:
```cmd
mvn -version
```

### API não inicia
- Verifique se a porta 9090 está livre
- Use porta diferente: `java -jar target\Pertocheck502s.jar --api 8080`

## 📝 Licença

Este projeto é proprietário.

## 👥 Autores

- Rhuan (Desenvolvedor Original)
- Douglas (Manutenção)

## 📞 Suporte

Para suporte, entre em contato com a equipe de desenvolvimento.
