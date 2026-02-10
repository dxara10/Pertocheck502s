# 🚀 GUIA DE DEPLOY EM PRODUÇÃO - Pertocheck502s v2.1.0

## 📋 ARQUITETURAS POSSÍVEIS

---

## 🏗️ ARQUITETURA 1: API LOCAL (Recomendado)

### Conceito
A API roda **na mesma máquina** onde está a impressora física.

```
┌─────────────────────────────────────────┐
│  MÁQUINA COM IMPRESSORA                 │
│                                         │
│  ┌──────────────┐    ┌──────────────┐ │
│  │  API REST    │───▶│  Impressora  │ │
│  │  :8080       │    │  COM1        │ │
│  └──────────────┘    └──────────────┘ │
│         ▲                               │
└─────────┼───────────────────────────────┘
          │
    ┌─────┴─────┐
    │  Sistema  │
    │  Web/ERP  │
    └───────────┘
```

### ✅ Vantagens
- Acesso direto à porta serial
- Sem latência de rede
- Mais seguro (sem exposição externa)
- Simples de configurar

### ❌ Desvantagens
- Precisa de máquina dedicada
- Acesso limitado à rede local

### 📝 Como Implementar

#### 1. Instalar na Máquina com Impressora
```bash
# Execute o instalador
Pertocheck502s-Setup-v2.1.0.exe

# Ou manualmente
java -jar Pertocheck502s.jar --api
```

#### 2. Configurar como Serviço Windows

**Criar arquivo:** `C:\Pertocheck502s\start-api.bat`
```batch
@echo off
cd "C:\Program Files\Pertocheck502s"
java -jar Pertocheck502s.jar --api 8080
```

**Instalar como serviço usando NSSM:**
```bash
# Baixar NSSM: https://nssm.cc/download
nssm install Pertocheck502sAPI "C:\Pertocheck502s\start-api.bat"
nssm set Pertocheck502sAPI Start SERVICE_AUTO_START
nssm start Pertocheck502sAPI
```

#### 3. Configurar Firewall
```bash
# Permitir porta 8080
netsh advfirewall firewall add rule name="Pertocheck API" dir=in action=allow protocol=TCP localport=8080
```

#### 4. Apontar Sistema para API
```javascript
// No seu sistema web/ERP
const API_URL = 'http://192.168.1.100:8080'; // IP da máquina com impressora

fetch(`${API_URL}/api/cheque/imprimir`, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(dadosCheque)
});
```

---

## 🐳 ARQUITETURA 2: DOCKER CONTAINER (Híbrido)

### Conceito
API em container Docker, mas com acesso à porta serial do host.

```
┌─────────────────────────────────────────┐
│  MÁQUINA COM IMPRESSORA                 │
│                                         │
│  ┌────────────────────┐                │
│  │  DOCKER CONTAINER  │                │
│  │  ┌──────────────┐  │  ┌──────────┐ │
│  │  │  API REST    │──┼─▶│Impressora│ │
│  │  │  :8080       │  │  │  COM1    │ │
│  │  └──────────────┘  │  └──────────┘ │
│  └────────────────────┘                │
└─────────────────────────────────────────┘
```

### ✅ Vantagens
- Isolamento da aplicação
- Fácil atualização
- Portabilidade

### ❌ Desvantagens
- Complexidade adicional
- Acesso serial pode ser problemático no Windows

### 📝 Como Implementar

#### 1. Criar Dockerfile
```dockerfile
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

COPY target/Pertocheck502s.jar /app/
COPY config.txt /app/

EXPOSE 8080

CMD ["java", "-jar", "Pertocheck502s.jar", "--api", "8080"]
```

#### 2. Criar docker-compose.yml
```yaml
version: '3.8'

services:
  pertocheck-api:
    build: .
    ports:
      - "8080:8080"
    devices:
      - "/dev/ttyUSB0:/dev/ttyUSB0"  # Linux
    volumes:
      - ./config.txt:/app/config.txt
    restart: unless-stopped
```

#### 3. Build e Run
```bash
docker-compose up -d
```

**⚠️ NOTA:** No Windows, acesso serial via Docker é limitado. Recomenda-se Arquitetura 1.

---

## ☁️ ARQUITETURA 3: SERVIDOR CENTRALIZADO + AGENTES

### Conceito
API central recebe requisições e distribui para agentes locais nas máquinas com impressoras.

```
┌──────────────┐
│  Sistema Web │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  API Central │ (Servidor na nuvem/rede)
│  :8080       │
└──────┬───────┘
       │
   ┌───┴────┬────────┐
   ▼        ▼        ▼
┌─────┐  ┌─────┐  ┌─────┐
│Agent│  │Agent│  │Agent│ (Máquinas com impressoras)
│ :8081│  │:8082│  │:8083│
└──┬──┘  └──┬──┘  └──┬──┘
   │        │        │
   ▼        ▼        ▼
 [IMP1]   [IMP2]   [IMP3]
```

### ✅ Vantagens
- Múltiplas impressoras
- Gerenciamento centralizado
- Balanceamento de carga

### ❌ Desvantagens
- Arquitetura complexa
- Requer desenvolvimento adicional

### 📝 Como Implementar

**Requer desenvolvimento de:**
1. API Central (roteador)
2. Sistema de registro de agentes
3. Fila de impressão
4. Monitoramento

---

## 🌐 ARQUITETURA 4: REVERSE PROXY (Produção)

### Conceito
Nginx/Apache na frente da API para SSL, autenticação e cache.

```
Internet
   │
   ▼
┌──────────────┐
│    Nginx     │ :443 (HTTPS)
│  + SSL/TLS   │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  API REST    │ :8080 (HTTP)
└──────┬───────┘
       │
       ▼
   [Impressora]
```

### ✅ Vantagens
- HTTPS/SSL
- Autenticação
- Rate limiting
- Logs centralizados

### 📝 Como Implementar

#### 1. Instalar Nginx
```bash
# Windows: https://nginx.org/en/download.html
```

#### 2. Configurar nginx.conf
```nginx
server {
    listen 443 ssl;
    server_name api.pertocheck.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    location /api/ {
        proxy_pass http://localhost:8080/api/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        
        # Autenticação básica
        auth_basic "API Pertocheck";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }
}
```

#### 3. Criar usuário
```bash
htpasswd -c /etc/nginx/.htpasswd admin
```

#### 4. Usar API com autenticação
```javascript
fetch('https://api.pertocheck.com/api/cheque/imprimir', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Basic ' + btoa('admin:senha')
  },
  body: JSON.stringify(dados)
});
```

---

## 🎯 RECOMENDAÇÃO POR CENÁRIO

### Cenário 1: Pequena Empresa (1 impressora)
**✅ ARQUITETURA 1 - API Local**
- Instalar na máquina com impressora
- Configurar como serviço Windows
- Sistema web aponta para IP local

### Cenário 2: Média Empresa (2-5 impressoras)
**✅ ARQUITETURA 1 + Load Balancer**
- Uma API por impressora
- Load balancer simples no sistema web
```javascript
const APIS = [
  'http://192.168.1.100:8080',
  'http://192.168.1.101:8080',
  'http://192.168.1.102:8080'
];

function getNextAPI() {
  return APIS[Math.floor(Math.random() * APIS.length)];
}
```

### Cenário 3: Grande Empresa (5+ impressoras)
**✅ ARQUITETURA 3 - Servidor Centralizado**
- Desenvolver API central
- Agentes em cada máquina
- Fila de impressão

### Cenário 4: Acesso Externo/Internet
**✅ ARQUITETURA 4 - Reverse Proxy**
- Nginx com SSL
- Autenticação obrigatória
- VPN recomendada

---

## 🔒 SEGURANÇA EM PRODUÇÃO

### 1. Autenticação
```java
// Adicionar no RestApiServer.java
before("/api/*", (request, response) -> {
    String auth = request.headers("Authorization");
    if (auth == null || !validarToken(auth)) {
        halt(401, "Não autorizado");
    }
});
```

### 2. HTTPS
- Use certificado SSL (Let's Encrypt gratuito)
- Configure Nginx/Apache como proxy

### 3. Rate Limiting
```java
// Limitar requisições por IP
private static Map<String, Integer> requestCount = new HashMap<>();

before("/api/*", (request, response) -> {
    String ip = request.ip();
    int count = requestCount.getOrDefault(ip, 0);
    if (count > 100) { // 100 req/min
        halt(429, "Muitas requisições");
    }
    requestCount.put(ip, count + 1);
});
```

### 4. Firewall
```bash
# Permitir apenas IPs específicos
netsh advfirewall firewall add rule name="Pertocheck API" dir=in action=allow protocol=TCP localport=8080 remoteip=192.168.1.0/24
```

---

## 📊 MONITORAMENTO

### 1. Health Check
```bash
# Criar script de monitoramento
@echo off
curl -s http://localhost:8080/api/status
if %ERRORLEVEL% NEQ 0 (
    echo API offline! Reiniciando...
    net stop Pertocheck502sAPI
    net start Pertocheck502sAPI
)
```

### 2. Logs
```bash
# Rotação de logs
forfiles /p "C:\Windows\Temp" /m log.txt /d -7 /c "cmd /c del @path"
```

### 3. Alertas
- Configure alertas por email/SMS quando API cair
- Use ferramentas como Zabbix, Nagios, ou Uptime Robot

---

## 🚀 DEPLOY PASSO A PASSO (Produção)

### Passo 1: Preparar Máquina
```bash
# Instalar Java 21
# Instalar Pertocheck502s
# Configurar impressora
```

### Passo 2: Configurar Serviço
```bash
# Usar NSSM para criar serviço Windows
nssm install Pertocheck502sAPI "C:\Program Files\Pertocheck502s\Pertocheck502s.jar" --api 8080
```

### Passo 3: Configurar Firewall
```bash
netsh advfirewall firewall add rule name="Pertocheck API" dir=in action=allow protocol=TCP localport=8080
```

### Passo 4: Testar
```bash
curl http://localhost:8080/api/status
```

### Passo 5: Configurar Sistema Cliente
```javascript
// config.js
export const API_CONFIG = {
  baseURL: 'http://192.168.1.100:8080',
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json'
  }
};
```

### Passo 6: Monitorar
- Verificar logs diariamente
- Configurar backup do config.txt
- Testar impressão semanalmente

---

## 📞 SUPORTE

### Problemas Comuns

**API não responde da rede:**
- Verificar firewall
- Testar com `telnet IP 8080`
- Verificar se serviço está rodando

**Timeout nas requisições:**
- Aumentar timeout do cliente
- Verificar se impressora está respondendo
- Verificar logs

**Múltiplas requisições simultâneas:**
- API suporta múltiplas conexões
- Mas impressora processa uma por vez
- Implementar fila no cliente se necessário

---

## 📝 CHECKLIST DE PRODUÇÃO

- [ ] Java 21 instalado
- [ ] Pertocheck502s instalado
- [ ] Impressora configurada e testada
- [ ] API rodando como serviço
- [ ] Firewall configurado
- [ ] IP fixo configurado
- [ ] Sistema cliente apontando para API
- [ ] Testes de impressão realizados
- [ ] Monitoramento configurado
- [ ] Backup de configuração
- [ ] Documentação entregue à equipe

---

**Deploy em produção facilitado! 🚀**
