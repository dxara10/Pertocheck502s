# 🔧 INSTALAÇÃO DE DEPENDÊNCIAS

## Pertocheck502s v2.1.0 - Guia de Instalação

---

## 📦 DEPENDÊNCIAS NECESSÁRIAS

### 1. Java 21 LTS
### 2. Apache Maven 3.6+

---

## ☕ INSTALANDO JAVA 21

### Opção 1: Eclipse Temurin (Recomendado)

1. **Baixar:**
   - Acesse: https://adoptium.net/
   - Selecione: **Java 21 (LTS)**
   - Sistema: **Windows x64**
   - Tipo: **JDK**

2. **Instalar:**
   - Execute o instalador baixado
   - ✅ Marque: "Set JAVA_HOME variable"
   - ✅ Marque: "Add to PATH"
   - Clique em "Install"

3. **Verificar:**
   ```bash
   java -version
   # Deve mostrar: openjdk version "21.x.x"
   ```

### Opção 2: Oracle JDK

1. **Baixar:**
   - Acesse: https://www.oracle.com/java/technologies/downloads/#java21
   - Baixe: Windows x64 Installer

2. **Instalar:**
   - Execute o instalador
   - Siga as instruções padrão

3. **Configurar Variáveis de Ambiente:**
   ```
   JAVA_HOME = C:\Program Files\Java\jdk-21
   PATH = %JAVA_HOME%\bin
   ```

---

## 🔨 INSTALANDO MAVEN

### Passo 1: Baixar

1. Acesse: https://maven.apache.org/download.cgi
2. Baixe: **apache-maven-3.9.x-bin.zip**
3. Extraia para: `C:\Program Files\Apache\maven`

### Passo 2: Configurar Variáveis de Ambiente

1. **Abrir Variáveis de Ambiente:**
   - Pressione `Win + Pause`
   - Clique em "Configurações avançadas do sistema"
   - Clique em "Variáveis de Ambiente"

2. **Criar MAVEN_HOME:**
   - Clique em "Novo" (Variáveis do sistema)
   - Nome: `MAVEN_HOME`
   - Valor: `C:\Program Files\Apache\maven`

3. **Adicionar ao PATH:**
   - Selecione a variável "Path"
   - Clique em "Editar"
   - Clique em "Novo"
   - Adicione: `%MAVEN_HOME%\bin`

### Passo 3: Verificar

```bash
mvn -version
# Deve mostrar: Apache Maven 3.9.x
```

---

## 🎯 INSTALAÇÃO RÁPIDA (Chocolatey)

Se você tem o Chocolatey instalado:

```bash
# Instalar Java 21
choco install temurin21

# Instalar Maven
choco install maven

# Verificar
java -version
mvn -version
```

---

## 🎯 INSTALAÇÃO RÁPIDA (Winget)

Se você tem o Winget (Windows 11):

```bash
# Instalar Java 21
winget install EclipseAdoptium.Temurin.21.JDK

# Instalar Maven
winget install Apache.Maven

# Verificar
java -version
mvn -version
```

---

## ✅ VERIFICAÇÃO COMPLETA

Execute este script para verificar tudo:

```bash
@echo off
echo ========================================
echo  Verificacao de Dependencias
echo ========================================
echo.

echo [1/2] Verificando Java...
java -version
if %ERRORLEVEL% NEQ 0 (
    echo ERRO: Java nao encontrado!
    echo Instale Java 21 de: https://adoptium.net/
    pause
    exit /b 1
)
echo OK!
echo.

echo [2/2] Verificando Maven...
mvn -version
if %ERRORLEVEL% NEQ 0 (
    echo ERRO: Maven nao encontrado!
    echo Instale Maven de: https://maven.apache.org/download.cgi
    pause
    exit /b 1
)
echo OK!
echo.

echo ========================================
echo  Todas as dependencias estao OK!
echo ========================================
pause
```

Salve como `verificar_dependencias.bat` e execute.

---

## 🔧 CONFIGURAÇÃO DO MAVEN (Opcional)

### Configurar Proxy (se necessário)

Edite: `C:\Program Files\Apache\maven\conf\settings.xml`

```xml
<proxies>
  <proxy>
    <id>proxy</id>
    <active>true</active>
    <protocol>http</protocol>
    <host>proxy.empresa.com</host>
    <port>8080</port>
  </proxy>
</proxies>
```

### Configurar Repositório Local

```xml
<localRepository>C:/Users/SeuUsuario/.m2/repository</localRepository>
```

---

## 🐛 SOLUÇÃO DE PROBLEMAS

### Java não reconhecido

**Problema:**
```
'java' não é reconhecido como um comando interno ou externo
```

**Solução:**
1. Verificar se JAVA_HOME está configurado
2. Verificar se %JAVA_HOME%\bin está no PATH
3. Reiniciar o terminal/prompt

### Maven não reconhecido

**Problema:**
```
'mvn' não é reconhecido como um comando interno ou externo
```

**Solução:**
1. Verificar se MAVEN_HOME está configurado
2. Verificar se %MAVEN_HOME%\bin está no PATH
3. Reiniciar o terminal/prompt

### Versão errada do Java

**Problema:**
```
java version "1.8.0_xxx"
```

**Solução:**
1. Desinstalar versões antigas do Java
2. Instalar Java 21
3. Verificar JAVA_HOME aponta para Java 21
4. Reiniciar o terminal

### Maven baixa dependências lentamente

**Solução:**
1. Configurar mirror mais próximo
2. Verificar conexão com internet
3. Desabilitar antivírus temporariamente

---

## 📋 CHECKLIST DE INSTALAÇÃO

- [ ] Java 21 baixado
- [ ] Java 21 instalado
- [ ] JAVA_HOME configurado
- [ ] Java no PATH
- [ ] `java -version` funciona
- [ ] Maven baixado
- [ ] Maven extraído
- [ ] MAVEN_HOME configurado
- [ ] Maven no PATH
- [ ] `mvn -version` funciona
- [ ] Terminal reiniciado
- [ ] Tudo funcionando!

---

## 🎓 RECURSOS ADICIONAIS

### Documentação Oficial
- Java: https://docs.oracle.com/en/java/javase/21/
- Maven: https://maven.apache.org/guides/

### Tutoriais
- Java: https://dev.java/learn/
- Maven: https://maven.apache.org/guides/getting-started/

### Comunidade
- Stack Overflow: https://stackoverflow.com/questions/tagged/java
- Maven Users: https://maven.apache.org/mailing-lists.html

---

## ✅ PRÓXIMO PASSO

Após instalar todas as dependências:

```bash
cd C:\Users\Douglas\Documents\Flex\Impressora\Pertocheck502s
build.bat
```

---

**Instalação completa? Vá para INICIO_RAPIDO.md** 🚀
