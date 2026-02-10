# 📦 INSTALADOR - Pertocheck502s v2.1.0

## 🚀 INSTALAÇÃO RÁPIDA

### Opção 1: Instalador Simples (Recomendado)
1. Clique com botão direito em `install.bat`
2. Selecione **"Executar como administrador"**
3. Siga as instruções na tela
4. Pronto! ✅

### Opção 2: Instalador MSI (Requer WiX Toolset)
1. Execute `build-installer-jpackage.bat`
2. Instale o arquivo `.msi` gerado

### Opção 3: Instalador Inno Setup (Requer Inno Setup 6)
1. Instale Inno Setup: https://jrsoftware.org/isdl.php
2. Execute `build-installer.bat`
3. Instale o arquivo `.exe` gerado

---

## 📋 PRÉ-REQUISITOS

- **Java 21** ou superior
  - Download: https://adoptium.net/
  - O instalador verifica e avisa se não estiver instalado

---

## 📂 O QUE SERÁ INSTALADO

```
C:\Program Files\Pertocheck502s\
├── Pertocheck502s.jar          # Aplicação principal
├── icon2.ico                   # Ícone
├── docs\                       # Documentação
│   ├── README.md
│   └── INICIO_RAPIDO.md
└── exemplos\                   # Arquivos de exemplo
    └── cheque_teste.txt

C:\ProgramData\Pertocheck502s\
└── config.txt                  # Configuração

Menu Iniciar > Pertocheck502s\
├── Pertocheck502s              # Atalho principal
└── Configuração                # Editar config.txt
```

---

## ⚙️ CONFIGURAÇÃO

Após instalar, edite o arquivo de configuração:
- **Menu Iniciar** > **Pertocheck502s** > **Configuração**
- Ou: `C:\ProgramData\Pertocheck502s\config.txt`

```
PORTA=COM1                      # Porta da impressora
BITS_PER_SECOND=9600           # Taxa de transmissão
DIRETORIO=C:\Users\...\Documents  # Diretório padrão
```

---

## 🗑️ DESINSTALAÇÃO

### Método 1: Painel de Controle
1. Painel de Controle > Programas > Desinstalar um programa
2. Selecione "Pertocheck502s 2.1.0"
3. Clique em "Desinstalar"

### Método 2: Manual
1. Execute: `C:\Program Files\Pertocheck502s\uninstall.bat`

---

## ✅ VERIFICAÇÃO

Após instalar:
1. Abra o Menu Iniciar
2. Procure por "Pertocheck502s"
3. Execute a aplicação
4. Teste com o arquivo de exemplo

---

## 🆘 PROBLEMAS

### Java não encontrado
- Instale Java 21: https://adoptium.net/
- Reinicie o computador
- Tente instalar novamente

### Erro de permissão
- Execute o instalador como administrador
- Clique com botão direito > "Executar como administrador"

### Aplicação não abre
- Verifique se Java está instalado: `java -version`
- Verifique logs em: `C:\Windows\Temp\log.txt`

---

**Instalador criado com ❤️ para facilitar sua vida!**
