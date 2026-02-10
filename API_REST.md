# 🌐 API REST - Pertocheck502s v2.1.0

## 📖 Documentação Completa da API

### 🚀 Início Rápido

#### Iniciar Servidor API
```bash
java -jar Pertocheck502s.jar --api
```

O servidor iniciará na porta **8080** por padrão.

Para usar outra porta:
```bash
java -jar Pertocheck502s.jar --api 9090
```

---

## 📡 Endpoints Disponíveis

### 1. Status da API
**GET** `/api/status`

Verifica se a API está funcionando.

**Exemplo:**
```bash
curl http://localhost:8080/api/status
```

**Resposta:**
```json
{
  "sucesso": true,
  "mensagem": "API funcionando",
  "dados": {
    "versao": "2.1.0",
    "status": "online",
    "timestamp": "Sun Feb 09 23:20:00 BRT 2026"
  }
}
```

---

### 2. Imprimir Cheque
**POST** `/api/cheque/imprimir`

Imprime um cheque com os dados fornecidos.

#### Parâmetros (JSON):

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| `valor` | String | ✅ Sim | Valor do cheque (ex: "1250.50") |
| `valorExtenso` | String | ❌ Não | Valor por extenso (informativo) |
| `beneficiario` | String | ✅ Sim | Nome do beneficiário |
| `cidade` | String | ✅ Sim | Cidade |
| `data` | String | ✅ Sim | Data no formato dd/mm/aaaa |
| `numeroBanco` | String | ❌ Não | Número do banco (3 dígitos) |

#### Exemplo de Requisição:
```bash
curl -X POST http://localhost:8080/api/cheque/imprimir \
  -H "Content-Type: application/json" \
  -d '{
    "valor": "1250.50",
    "valorExtenso": "Mil duzentos e cinquenta reais e cinquenta centavos",
    "beneficiario": "JOSE DA SILVA",
    "cidade": "SAO PAULO",
    "data": "09/02/2026",
    "numeroBanco": "123"
  }'
```

#### Resposta de Sucesso (200):
```json
{
  "sucesso": true,
  "mensagem": "Cheque impresso com sucesso"
}
```

#### Resposta de Erro (400/500):
```json
{
  "sucesso": false,
  "mensagem": "Erro ao imprimir: Porta COM1 não encontrada"
}
```

---

### 3. Documentação Interativa
**GET** `/api/docs`

Abre documentação HTML interativa no navegador.

```bash
# Abrir no navegador
http://localhost:8080/api/docs
```

---

## 💻 Exemplos em Diferentes Linguagens

### JavaScript (Fetch API)
```javascript
fetch('http://localhost:8080/api/cheque/imprimir', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    valor: '1250.50',
    valorExtenso: 'Mil duzentos e cinquenta reais',
    beneficiario: 'JOSE DA SILVA',
    cidade: 'SAO PAULO',
    data: '09/02/2026',
    numeroBanco: '123'
  })
})
.then(response => response.json())
.then(data => {
  if (data.sucesso) {
    console.log('Cheque impresso com sucesso!');
  } else {
    console.error('Erro:', data.mensagem);
  }
})
.catch(error => console.error('Erro na requisição:', error));
```

### Python (requests)
```python
import requests

url = 'http://localhost:8080/api/cheque/imprimir'
dados = {
    'valor': '1250.50',
    'valorExtenso': 'Mil duzentos e cinquenta reais',
    'beneficiario': 'JOSE DA SILVA',
    'cidade': 'SAO PAULO',
    'data': '09/02/2026',
    'numeroBanco': '123'
}

response = requests.post(url, json=dados)
resultado = response.json()

if resultado['sucesso']:
    print('Cheque impresso com sucesso!')
else:
    print(f"Erro: {resultado['mensagem']}")
```

### C# (HttpClient)
```csharp
using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

class Program
{
    static async Task Main()
    {
        var client = new HttpClient();
        var dados = new
        {
            valor = "1250.50",
            valorExtenso = "Mil duzentos e cinquenta reais",
            beneficiario = "JOSE DA SILVA",
            cidade = "SAO PAULO",
            data = "09/02/2026",
            numeroBanco = "123"
        };

        var json = JsonSerializer.Serialize(dados);
        var content = new StringContent(json, Encoding.UTF8, "application/json");

        var response = await client.PostAsync(
            "http://localhost:8080/api/cheque/imprimir",
            content
        );

        var resultado = await response.Content.ReadAsStringAsync();
        Console.WriteLine(resultado);
    }
}
```

### PHP
```php
<?php
$url = 'http://localhost:8080/api/cheque/imprimir';
$dados = array(
    'valor' => '1250.50',
    'valorExtenso' => 'Mil duzentos e cinquenta reais',
    'beneficiario' => 'JOSE DA SILVA',
    'cidade' => 'SAO PAULO',
    'data' => '09/02/2026',
    'numeroBanco' => '123'
);

$options = array(
    'http' => array(
        'header'  => "Content-type: application/json\r\n",
        'method'  => 'POST',
        'content' => json_encode($dados)
    )
);

$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
$response = json_decode($result, true);

if ($response['sucesso']) {
    echo "Cheque impresso com sucesso!";
} else {
    echo "Erro: " . $response['mensagem'];
}
?>
```

### Java
```java
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class ChequeAPI {
    public static void main(String[] args) throws Exception {
        HttpClient client = HttpClient.newHttpClient();
        
        String json = """
            {
                "valor": "1250.50",
                "valorExtenso": "Mil duzentos e cinquenta reais",
                "beneficiario": "JOSE DA SILVA",
                "cidade": "SAO PAULO",
                "data": "09/02/2026",
                "numeroBanco": "123"
            }
            """;
        
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("http://localhost:8080/api/cheque/imprimir"))
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(json))
            .build();
        
        HttpResponse<String> response = client.send(
            request,
            HttpResponse.BodyHandlers.ofString()
        );
        
        System.out.println(response.body());
    }
}
```

---

## 🔒 Códigos de Status HTTP

| Código | Descrição |
|--------|-----------|
| **200** | Sucesso - Operação realizada com sucesso |
| **400** | Bad Request - Parâmetros inválidos ou faltando |
| **404** | Not Found - Endpoint não encontrado |
| **500** | Internal Server Error - Erro no servidor/impressora |

---

## ⚙️ Configuração

A API usa o mesmo arquivo de configuração da aplicação GUI:

**Localização:** `C:\ProgramData\Pertocheck502s\config.txt`

```
PORTA=COM1
BITS_PER_SECOND=9600
DIRETORIO=C:\Users\...\Documents
```

---

## 🐛 Solução de Problemas

### API não inicia
```bash
# Verificar se a porta está em uso
netstat -ano | findstr :8080

# Usar outra porta
java -jar Pertocheck502s.jar --api 9090
```

### Erro de conexão com impressora
- Verifique se a impressora está conectada
- Confirme a porta COM no arquivo de configuração
- Teste primeiro com a interface gráfica

### Timeout na requisição
- Aumente o timeout do cliente HTTP
- Verifique se a impressora está respondendo
- Consulte os logs em `C:\Windows\Temp\log.txt`

---

## 📊 Logs

Todos os logs da API são salvos em:
```
C:\Windows\Temp\log.txt
```

Para visualizar em tempo real:
```bash
tail -f C:\Windows\Temp\log.txt
```

---

## 🔄 CORS

A API possui CORS habilitado para todas as origens (`*`), permitindo requisições de qualquer domínio.

---

## 🚀 Integração com Sistemas

### Exemplo: Sistema Web
```html
<!DOCTYPE html>
<html>
<head>
    <title>Impressão de Cheques</title>
</head>
<body>
    <h1>Imprimir Cheque</h1>
    <form id="chequeForm">
        <input type="text" id="valor" placeholder="Valor" required>
        <input type="text" id="beneficiario" placeholder="Beneficiário" required>
        <input type="text" id="cidade" placeholder="Cidade" required>
        <input type="date" id="data" required>
        <button type="submit">Imprimir</button>
    </form>

    <script>
        document.getElementById('chequeForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            
            const dados = {
                valor: document.getElementById('valor').value,
                beneficiario: document.getElementById('beneficiario').value,
                cidade: document.getElementById('cidade').value,
                data: document.getElementById('data').value
            };

            try {
                const response = await fetch('http://localhost:8080/api/cheque/imprimir', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(dados)
                });

                const result = await response.json();
                alert(result.mensagem);
            } catch (error) {
                alert('Erro ao imprimir: ' + error.message);
            }
        });
    </script>
</body>
</html>
```

---

## 📞 Suporte

Para problemas com a API:
1. Verifique os logs em `C:\Windows\Temp\log.txt`
2. Teste o endpoint `/api/status`
3. Verifique a configuração da impressora

---

**API REST criada com ❤️ para facilitar a integração!**
