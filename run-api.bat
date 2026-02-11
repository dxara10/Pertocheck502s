@echo off
echo ========================================
echo  Pertocheck502s - API REST
echo  Versao 2.1.0
echo ========================================
echo.

if not exist "target\Pertocheck502s.jar" (
    echo ERRO: JAR nao encontrado!
    echo Compilando projeto...
    echo.
    call build.bat
    if %ERRORLEVEL% NEQ 0 (
        echo ERRO na compilacao!
        pause
        exit /b 1
    )
)

echo Iniciando API REST na porta 9090...
echo.
echo Endpoints disponiveis:
echo   http://localhost:9090/api/status
echo   http://localhost:9090/api/docs
echo   http://localhost:9090/api/cheque/imprimir
echo.
echo Pressione Ctrl+C para parar o servidor
echo.

java -jar target\Pertocheck502s.jar --api 9090

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERRO ao executar a API!
    echo.
    echo Verifique:
    echo 1. Java 21 esta instalado? (java -version)
    echo 2. Porta 9090 esta disponivel?
    echo 3. Arquivo config.txt existe?
    echo.
    pause
)
