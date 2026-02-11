# Instalador Pertocheck502s v2.1.0

## 📦 Conteúdo

Este instalador contém:
- ✅ Pertocheck502s.jar (aplicação completa)
- ✅ Documentação completa
- ✅ Guia para programadores PHP
- ✅ Arquivo de exemplo de cheque

## 🚀 Como Instalar

1. **Execute como Administrador**
   - Clique com botão direito em `install.bat`
   - Selecione "Executar como administrador"

2. **Siga as instruções na tela**
   - O instalador verificará se Java está instalado
   - Criará os diretórios necessários
   - Copiará os arquivos
   - Criará atalhos no Menu Iniciar

3. **Configure a porta serial**
   - Após instalação, edite: `C:\ProgramData\Pertocheck502s\config.txt`
   - Defina a porta COM correta (ex: COM3)

## 📍 Locais de Instalação

- **Aplicação**: `C:\Program Files\Pertocheck502s\`
- **Configuração**: `C:\ProgramData\Pertocheck502s\config.txt`
- **Logs**: `C:\Windows\Temp\log.txt`
- **Atalhos**: Menu Iniciar > Pertocheck502s

## 📚 Documentação

Após instalação, acesse:
- `C:\Program Files\Pertocheck502s\docs\README.md`
- `C:\Program Files\Pertocheck502s\docs\INICIO_RAPIDO.md`
- `C:\Program Files\Pertocheck502s\docs\GUIA_PHP.md`

## 🔧 Requisitos

- Windows 7 ou superior
- Java 21 ou superior
- Impressora Perto Check 502S conectada via serial

## ⚙️ Executar API REST

Após instalação, para iniciar a API:

```bash
cd "C:\Program Files\Pertocheck502s"
java -jar Pertocheck502s.jar --api
```

A API estará disponível em: `http://localhost:9090`

## 🗑️ Desinstalar

- Painel de Controle > Programas > Desinstalar um programa
- Ou execute: `C:\Program Files\Pertocheck502s\uninstall.bat`

## 📞 Suporte

Para problemas técnicos, verifique os logs em `C:\Windows\Temp\log.txt`
