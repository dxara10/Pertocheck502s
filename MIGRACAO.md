# 🔄 Guia de Migração - Pertocheck502s v2.1.0

## 📊 Comparação de Versões

| Aspecto | Versão Antiga | Versão 2.1.0 |
|---------|---------------|--------------|
| Java | 8 (32-bits) | 21 LTS |
| Comunicação Serial | javax.comm (obsoleto) | jSerialComm |
| Build | Ant + NetBeans | Maven |
| Tamanho | ~150MB (com JRE) | ~5MB (JAR único) |
| Dependências | Embarcadas | Gerenciadas |
| Manutenibilidade | Baixa | Alta |

---

## ✅ Checklist de Migração

### 1. Pré-requisitos
- [ ] Java 21 instalado
- [ ] Maven 3.6+ instalado
- [ ] Backup da versão antiga
- [ ] Arquivo config.txt salvo

### 2. Instalação
- [ ] Clonar/baixar versão 2.1.0
- [ ] Copiar config.txt para `C:\Windows\Temp\`
- [ ] Executar `build.bat`
- [ ] Testar com arquivo de cheque de exemplo

### 3. Validação
- [ ] Aplicação inicia corretamente
- [ ] Comunicação com impressora funciona
- [ ] Impressão de cheque teste OK
- [ ] Logs sendo gerados

---

## 🔧 Mudanças Técnicas

### Comunicação Serial

**Antes (javax.comm):**
```java
CommPortIdentifier portId = CommPortIdentifier.getPortIdentifier(porta);
SerialPort serialPort = (SerialPort) portId.open("App", 500);
```

**Depois (jSerialComm):**
```java
SerialPort porta = SerialPort.getCommPort(portaStr);
porta.openPort();
```

### Build

**Antes (Ant):**
```bash
ant clean
ant jar
```

**Depois (Maven):**
```bash
mvn clean package
```

---

## 🐛 Correções Implementadas

### Bug Crítico: Listeners Duplicados
**Problema:** Cada vez que selecionava um arquivo, adicionava um novo listener ao botão Imprimir, causando múltiplas impressões.

**Solução:** Listener do botão Imprimir movido para fora do listener de seleção de arquivo.

### Dependências Obsoletas
**Problema:** javax.comm não funciona em Java moderno.

**Solução:** Substituído por jSerialComm, biblioteca moderna e mantida.

---

## 📦 Estrutura de Arquivos

### Arquivos Novos:
```
pom.xml                              # Configuração Maven
build.bat                            # Script de build
run.bat                              # Script de execução
.gitignore                           # Controle de versão
MIGRACAO.md                          # Este arquivo
src/comunicacao/PchekCommModerno.java # Nova implementação serial
```

### Arquivos Modificados:
```
src/comunicacao/PCheck.java          # Usa nova implementação
src/visualizacao/JFramePrincipal.java # Bug corrigido
src/controle/CArquivoToCheque.java   # Commons Lang 3
README.md                            # Documentação atualizada
```

### Arquivos Obsoletos (podem ser removidos):
```
Pertocheck502s/executavel/JRE/       # JRE embarcado (150MB)
Pertocheck502s/lib/*.jar             # Dependências antigas
Pertocheck502s/nbproject/            # Configuração NetBeans
build.xml                            # Build Ant
```

---

## 🚀 Passos de Migração

### Passo 1: Instalar Java 21
```bash
# Verificar instalação
java -version
# Deve mostrar: openjdk version "21.x.x"
```

### Passo 2: Instalar Maven
```bash
# Verificar instalação
mvn -version
# Deve mostrar: Apache Maven 3.x.x
```

### Passo 3: Compilar Projeto
```bash
cd C:\Users\Douglas\Documents\Flex\Impressora\Pertocheck502s
build.bat
```

### Passo 4: Configurar
Copiar ou criar `C:\Windows\Temp\config.txt`:
```
PORTA=COM1
BITS_PER_SECOND=9600
DIRETORIO=
```

### Passo 5: Testar
```bash
run.bat
```

---

## ⚠️ Problemas Conhecidos e Soluções

### Problema: "mvn não é reconhecido"
**Solução:** Adicionar Maven ao PATH do Windows

### Problema: "Java version mismatch"
**Solução:** Verificar JAVA_HOME apontando para Java 21

### Problema: "Porta COM não encontrada"
**Solução:** Verificar porta no Gerenciador de Dispositivos

---

## 📈 Benefícios da Migração

✅ **Segurança:** Java 21 com patches de segurança atualizados
✅ **Performance:** Melhorias de performance do Java moderno
✅ **Manutenibilidade:** Código mais limpo e organizado
✅ **Tamanho:** 97% menor (5MB vs 150MB)
✅ **Dependências:** Gerenciadas automaticamente pelo Maven
✅ **Bugs:** Correção de bugs críticos da versão antiga

---

## 🔄 Rollback (se necessário)

Se precisar voltar para a versão antiga:

1. Manter backup da pasta `executavel/`
2. Executar `executavel/Transoft.exe`
3. Restaurar `config.txt` original

---

## 📞 Suporte

Em caso de problemas na migração:
1. Ativar modo "Suporte" na aplicação
2. Coletar arquivo `C:\Windows\Temp\log.txt`
3. Documentar o erro encontrado

---

## ✨ Próximos Passos (Opcional)

- [ ] Criar instalador Windows (.msi)
- [ ] Adicionar testes automatizados
- [ ] Interface gráfica modernizada
- [ ] Suporte a múltiplas impressoras
- [ ] Configuração via interface gráfica
