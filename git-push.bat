@echo off
echo ========================================
echo  Git Push - Pertocheck502s
echo ========================================
echo.

REM Verifica se Git está instalado
where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERRO: Git nao encontrado!
    echo Instale o Git: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo [1/6] Verificando repositorio Git...
if not exist ".git" (
    echo Inicializando repositorio Git...
    git init
    echo.
)

echo [2/6] Adicionando arquivos...
git add .
echo.

echo [3/6] Criando commit...
set /p mensagem="Digite a mensagem do commit (ou Enter para usar padrao): "
if "%mensagem%"=="" (
    set mensagem=Build completo - COM4 @ 2400 bps
)
git commit -m "%mensagem%"
echo.

echo [4/6] Configurando branch principal...
git branch -M main
echo.

echo [5/6] Adicionando repositorio remoto...
echo.
echo Digite a URL do repositorio GitHub:
echo Exemplo: https://github.com/usuario/pertocheck502s.git
set /p repo_url="URL: "

if "%repo_url%"=="" (
    echo ERRO: URL do repositorio nao pode ser vazia!
    pause
    exit /b 1
)

git remote remove origin 2>nul
git remote add origin %repo_url%
echo.

echo [6/6] Enviando para GitHub...
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo  SUCESSO!
    echo ========================================
    echo.
    echo Codigo enviado para: %repo_url%
    echo.
) else (
    echo.
    echo ========================================
    echo  ERRO ao enviar para GitHub!
    echo ========================================
    echo.
    echo Verifique:
    echo 1. URL do repositorio esta correta
    echo 2. Voce tem permissao de escrita
    echo 3. Autenticacao configurada (token/SSH)
    echo.
)

pause
