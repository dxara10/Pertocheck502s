# ⚡ INÍCIO RÁPIDO - Pertocheck502s v2.1.0

## 🎯 3 Passos para Começar

### 1️⃣ Compilar
```bash
build.bat
```

### 2️⃣ Configurar
Criar `C:\Windows\Temp\config.txt`:
```
PORTA=COM1
BITS_PER_SECOND=9600
DIRETORIO=
```

### 3️⃣ Executar
```bash
run.bat
```

---

## 📋 Pré-requisitos

- ✅ Java 21 instalado
- ✅ Maven 3.6+ instalado
- ✅ Impressora Perto Check 502S conectada

### Verificar instalação:
```bash
java -version    # Deve mostrar "21.x.x"
mvn -version     # Deve mostrar "3.x.x"
```

---

## 📄 Formato do Arquivo de Cheque

Criar arquivo .txt com 4 linhas:
```
1250.50
JOSE DA SILVA
SAO PAULO
31/12/2024
```

Ou 5 linhas (com banco):
```
123
1250.50
JOSE DA SILVA
SAO PAULO
31/12/2024
```

---

## 🆘 Problemas?

### Erro de compilação
```bash
# Limpar e recompilar
mvn clean
mvn package
```

### Porta COM não encontrada
1. Abrir Gerenciador de Dispositivos
2. Verificar porta da impressora
3. Atualizar config.txt

### Erro de comunicação
1. Verificar cabo conectado na entrada "Host"
2. Reiniciar impressora
3. Verificar taxa de transmissão (padrão: 9600)

---

## 📚 Documentação Completa

- **README.md** - Documentação detalhada
- **MIGRACAO.md** - Guia de migração
- **IMPLEMENTACAO.md** - Detalhes técnicos

---

## ✅ Checklist Rápido

- [ ] Java 21 instalado
- [ ] Maven instalado
- [ ] Projeto compilado (`build.bat`)
- [ ] Config.txt criado
- [ ] Impressora conectada
- [ ] Arquivo de teste criado
- [ ] Aplicação executada (`run.bat`)

---

**Pronto! Você está pronto para usar o Pertocheck502s v2.1.0** 🚀
