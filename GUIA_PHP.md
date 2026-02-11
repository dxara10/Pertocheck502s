# Guia Completo - API Pertocheck502s para Programadores PHP

## 📋 Pré-requisitos

### 1. Java 21 ou superior
```bash
# Verificar se Java está instalado
java -version

# Se não tiver, baixe em:
# https://adoptium.net/temurin/releases/?version=21
```

### 2. Impressora Perto Check 502S
- Conectada via cabo serial (USB-Serial ou Serial)
- Ligada e funcionando

---

## 🚀 Instalação e Configuração

### Passo 1: Baixar a Aplicação

Baixe o arquivo `Pertocheck502s.jar` e coloque em uma pasta, exemplo:
```
C:\Pertocheck502s\Pertocheck502s.jar
```

### Passo 2: Configurar a Porta Serial

1. Abra o **Gerenciador de Dispositivos** do Windows
2. Procure em **Portas (COM e LPT)**
3. Anote qual porta a impressora está (ex: COM3, COM4)

4. Crie o arquivo `C:\Windows\Temp\config.txt`:
```
PORTA=COM3
BITS_PER_SECOND=9600
DIRETORIO=
```

### Passo 3: Iniciar a API

Abra o **Prompt de Comando** ou **PowerShell** e execute:

```bash
cd C:\Pertocheck502s
java -jar Pertocheck502s.jar --api
```

Você verá:
```
========================================
  API REST - Pertocheck502s v2.1.0
========================================
Servidor rodando em: http://localhost:9090
Documentacao: http://localhost:9090/api/docs
========================================
```

✅ **A API está rodando!**

---

## 📡 Usando a API no PHP

### Endpoint Principal

```
POST http://localhost:9090/api/cheque/imprimir
Content-Type: application/json
```

### Parâmetros Obrigatórios

| Campo | Tipo | Descrição | Exemplo |
|-------|------|-----------|---------|
| `valor` | string | Valor do cheque | "1250.50" |
| `beneficiario` | string | Nome do beneficiário | "JOSE DA SILVA" |
| `cidade` | string | Cidade | "SAO PAULO" |
| `data` | string | Data (dd/mm/aaaa) | "10/02/2026" |

### Parâmetros Opcionais

| Campo | Tipo | Descrição | Exemplo |
|-------|------|-----------|---------|
| `numeroBanco` | string | Número do banco | "123" |
| `valorExtenso` | string | Valor por extenso | "Mil duzentos e cinquenta reais" |

---

## 💻 Exemplos de Código PHP

### Exemplo 1: Básico com cURL

```php
<?php

function imprimirCheque($valor, $beneficiario, $cidade, $data, $numeroBanco = null) {
    $url = 'http://localhost:9090/api/cheque/imprimir';
    
    $dados = [
        'valor' => $valor,
        'beneficiario' => $beneficiario,
        'cidade' => $cidade,
        'data' => $data
    ];
    
    if ($numeroBanco) {
        $dados['numeroBanco'] = $numeroBanco;
    }
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($dados));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json'
    ]);
    
    $resposta = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    $resultado = json_decode($resposta, true);
    
    if ($httpCode === 200 && $resultado['sucesso']) {
        return [
            'sucesso' => true,
            'mensagem' => $resultado['mensagem']
        ];
    } else {
        return [
            'sucesso' => false,
            'mensagem' => $resultado['mensagem'] ?? 'Erro desconhecido'
        ];
    }
}

// Exemplo de uso
$resultado = imprimirCheque(
    '1250.50',
    'JOSE DA SILVA',
    'SAO PAULO',
    '10/02/2026',
    '123'
);

if ($resultado['sucesso']) {
    echo "✅ Cheque impresso com sucesso!\n";
} else {
    echo "❌ Erro: " . $resultado['mensagem'] . "\n";
}
```

### Exemplo 2: Com Guzzle (Recomendado)

```php
<?php

require 'vendor/autoload.php';

use GuzzleHttp\Client;
use GuzzleHttp\Exception\RequestException;

class ChequeAPI {
    private $client;
    private $baseUrl = 'http://localhost:9090';
    
    public function __construct() {
        $this->client = new Client([
            'base_uri' => $this->baseUrl,
            'timeout' => 30.0,
        ]);
    }
    
    public function imprimir($dados) {
        try {
            $response = $this->client->post('/api/cheque/imprimir', [
                'json' => $dados,
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'
                ]
            ]);
            
            $body = json_decode($response->getBody(), true);
            
            return [
                'sucesso' => $body['sucesso'] ?? false,
                'mensagem' => $body['mensagem'] ?? 'Resposta inválida'
            ];
            
        } catch (RequestException $e) {
            if ($e->hasResponse()) {
                $body = json_decode($e->getResponse()->getBody(), true);
                return [
                    'sucesso' => false,
                    'mensagem' => $body['mensagem'] ?? $e->getMessage()
                ];
            }
            
            return [
                'sucesso' => false,
                'mensagem' => 'Erro de conexão: ' . $e->getMessage()
            ];
        }
    }
    
    public function verificarStatus() {
        try {
            $response = $this->client->get('/api/status');
            return json_decode($response->getBody(), true);
        } catch (RequestException $e) {
            return [
                'sucesso' => false,
                'mensagem' => 'API não está respondendo'
            ];
        }
    }
}

// Exemplo de uso
$api = new ChequeAPI();

// Verificar se API está online
$status = $api->verificarStatus();
if (!$status['sucesso']) {
    die("❌ API não está rodando!\n");
}

echo "✅ API está online - Versão: " . $status['versao'] . "\n\n";

// Imprimir cheque
$resultado = $api->imprimir([
    'valor' => '1250.50',
    'beneficiario' => 'JOSE DA SILVA',
    'cidade' => 'SAO PAULO',
    'data' => '10/02/2026',
    'numeroBanco' => '123'
]);

if ($resultado['sucesso']) {
    echo "✅ " . $resultado['mensagem'] . "\n";
} else {
    echo "❌ " . $resultado['mensagem'] . "\n";
}
```

### Exemplo 3: Laravel

```php
<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class ChequeService {
    
    private $baseUrl = 'http://localhost:9090';
    
    public function imprimir(array $dados) {
        try {
            $response = Http::timeout(30)
                ->post("{$this->baseUrl}/api/cheque/imprimir", $dados);
            
            $resultado = $response->json();
            
            if ($response->successful() && $resultado['sucesso']) {
                Log::info('Cheque impresso com sucesso', $dados);
                return [
                    'success' => true,
                    'message' => $resultado['mensagem']
                ];
            }
            
            Log::error('Erro ao imprimir cheque', [
                'dados' => $dados,
                'erro' => $resultado['mensagem'] ?? 'Erro desconhecido'
            ]);
            
            return [
                'success' => false,
                'message' => $resultado['mensagem'] ?? 'Erro ao imprimir cheque'
            ];
            
        } catch (\Exception $e) {
            Log::error('Exceção ao imprimir cheque', [
                'dados' => $dados,
                'exception' => $e->getMessage()
            ]);
            
            return [
                'success' => false,
                'message' => 'Erro de conexão com a impressora: ' . $e->getMessage()
            ];
        }
    }
    
    public function verificarStatus() {
        try {
            $response = Http::timeout(5)
                ->get("{$this->baseUrl}/api/status");
            
            return $response->successful();
        } catch (\Exception $e) {
            return false;
        }
    }
}

// Controller
namespace App\Http\Controllers;

use App\Services\ChequeService;
use Illuminate\Http\Request;

class ChequeController extends Controller {
    
    private $chequeService;
    
    public function __construct(ChequeService $chequeService) {
        $this->chequeService = $chequeService;
    }
    
    public function imprimir(Request $request) {
        $validated = $request->validate([
            'valor' => 'required|string',
            'beneficiario' => 'required|string|max:255',
            'cidade' => 'required|string|max:100',
            'data' => 'required|date_format:d/m/Y',
            'numeroBanco' => 'nullable|string|max:10'
        ]);
        
        $resultado = $this->chequeService->imprimir($validated);
        
        if ($resultado['success']) {
            return response()->json([
                'message' => $resultado['message']
            ], 200);
        }
        
        return response()->json([
            'message' => $resultado['message']
        ], 500);
    }
}
```

---

## 🔍 Testando a API

### Verificar Status
```bash
curl http://localhost:9090/api/status
```

Resposta:
```json
{
  "sucesso": true,
  "mensagem": "API funcionando",
  "versao": "2.1.0",
  "status": "online"
}
```

### Imprimir Cheque
```bash
curl -X POST http://localhost:9090/api/cheque/imprimir \
  -H "Content-Type: application/json" \
  -d '{
    "valor": "1250.50",
    "beneficiario": "JOSE DA SILVA",
    "cidade": "SAO PAULO",
    "data": "10/02/2026",
    "numeroBanco": "123"
  }'
```

---

## ⚠️ Tratamento de Erros

### Códigos HTTP

| Código | Significado |
|--------|-------------|
| 200 | Sucesso |
| 400 | Dados inválidos |
| 404 | Endpoint não encontrado |
| 500 | Erro na impressora |

### Exemplos de Erros

```json
{
  "sucesso": false,
  "mensagem": "Campo 'valor' e obrigatorio"
}
```

```json
{
  "sucesso": false,
  "mensagem": "Erro ao imprimir: A2 - Erro ao abrir a porta: COM3, verifique se a porta está disponível."
}
```

```json
{
  "sucesso": false,
  "mensagem": "Erro ao imprimir: 1005 - Equipamento ocupado/desligado/desconetado!"
}
```

---

## 🔧 Solução de Problemas

### API não responde
```php
// Verificar se a API está rodando
$ch = curl_init('http://localhost:9090/api/status');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 5);
$response = curl_exec($ch);
$error = curl_error($ch);
curl_close($ch);

if ($error) {
    echo "❌ API não está rodando. Inicie com: java -jar Pertocheck502s.jar --api\n";
} else {
    echo "✅ API está online\n";
}
```

### Erro de porta COM
1. Verifique no Gerenciador de Dispositivos qual porta está sendo usada
2. Atualize `C:\Windows\Temp\config.txt` com a porta correta
3. Reinicie a API

### Timeout
```php
// Aumentar timeout para impressões demoradas
curl_setopt($ch, CURLOPT_TIMEOUT, 60); // 60 segundos
```

---

## 🚀 Executar API como Serviço Windows

### Criar arquivo `start-api.bat`:
```batch
@echo off
cd C:\Pertocheck502s
java -jar Pertocheck502s.jar --api
```

### Executar ao iniciar o Windows:
1. Pressione `Win + R`
2. Digite `shell:startup`
3. Copie o arquivo `start-api.bat` para essa pasta

---

## 📚 Documentação Completa

Acesse no navegador:
```
http://localhost:9090/api/docs
```

---

## 💡 Dicas

1. **Sempre valide os dados** antes de enviar para a API
2. **Trate os erros** adequadamente no seu sistema
3. **Use logs** para debugar problemas
4. **Teste a conexão** antes de imprimir
5. **Mantenha a API rodando** em segundo plano

---

## 📞 Suporte

Para problemas técnicos:
- Ative o modo "Suporte" na interface gráfica
- Verifique os logs em `C:\Windows\Temp\log.txt`
- Teste a impressora manualmente antes de usar a API
