# Deploy para GitHub - Pertocheck502s

## ✅ Configuração Atual
- **Porta:** COM4
- **Baudrate:** 2400 bps
- **Versão:** 2.1.0

## 🚀 Deploy Rápido (Opção 1)

Execute um único comando:
```cmd
build-and-push.bat
```

Este script irá:
1. Fazer build completo do projeto
2. Inicializar Git (se necessário)
3. Fazer commit das alterações
4. Enviar para o GitHub

## 📝 Deploy Manual (Opção 2)

### 1. Build do Projeto
```cmd
rebuild.bat
```

### 2. Inicializar Git (primeira vez)
```cmd
git init
git branch -M main
```

### 3. Adicionar arquivos
```cmd
git add .
git commit -m "Build completo - COM4 @ 2400 bps"
```

### 4. Conectar ao GitHub
```cmd
git remote add origin https://github.com/SEU_USUARIO/pertocheck502s.git
git push -u origin main
```

## 🔑 Autenticação GitHub

### Opção 1: Token de Acesso Pessoal (Recomendado)
1. Acesse: https://github.com/settings/tokens
2. Gere um novo token (classic)
3. Marque: `repo` (acesso completo)
4. Use o token como senha ao fazer push

### Opção 2: SSH
1. Gere chave SSH:
```cmd
ssh-keygen -t ed25519 -C "seu-email@example.com"
```

2. Adicione ao GitHub:
```cmd
type %USERPROFILE%\.ssh\id_ed25519.pub
```

3. Cole em: https://github.com/settings/keys

4. Use URL SSH:
```cmd
git remote set-url origin git@github.com:SEU_USUARIO/pertocheck502s.git
```

## 📦 Arquivos Incluídos no Repositório

✅ Código fonte (src/)
✅ Configurações (config.txt, pom.xml)
✅ Scripts de execução (*.bat)
✅ Documentação (README.md, EXECUCAO.md)
✅ .gitignore

❌ target/ (build artifacts)
❌ .idea/ (IDE configs)
❌ *.jar (executáveis)
❌ logs/

## 🔍 Verificar antes do Push

```cmd
# Ver status
git status

# Ver arquivos que serão enviados
git ls-files

# Ver último commit
git log -1
```

## 🌐 Criar Repositório no GitHub

1. Acesse: https://github.com/new
2. Nome: `pertocheck502s`
3. Descrição: `Sistema de impressão de cheques Perto Check 502S`
4. Visibilidade: Privado (recomendado)
5. NÃO inicialize com README (já temos)
6. Clique em "Create repository"
7. Copie a URL do repositório

## 📋 Checklist Final

- [ ] Build concluído sem erros
- [ ] config.txt configurado (COM4 @ 2400)
- [ ] .gitignore criado
- [ ] README.md atualizado
- [ ] Repositório criado no GitHub
- [ ] Token/SSH configurado
- [ ] Push realizado com sucesso

## 🆘 Problemas Comuns

### "Maven não encontrado"
- Instale Maven: https://maven.apache.org/download.cgi
- Ou adicione ao PATH do Windows

### "Git não encontrado"
- Instale Git: https://git-scm.com/download/win

### "Authentication failed"
- Use token de acesso pessoal como senha
- Ou configure SSH

### "Remote origin already exists"
```cmd
git remote remove origin
git remote add origin <URL>
```

## 📞 Suporte

Para dúvidas, consulte a documentação completa em README.md
