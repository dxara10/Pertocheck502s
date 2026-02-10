@echo off
echo ========================================
echo  Pertocheck502s - Impressora de Cheques
echo  Versao 2.1.0
echo ========================================
echo.

if not exist "target\Pertocheck502s.jar" (
    echo ERRO: Arquivo JAR nao encontrado!
    echo Execute primeiro: build.bat
    echo.
    pause
    exit /b 1
)

echo Iniciando aplicacao...
echo.
java -jar target\Pertocheck502s.jar

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERRO ao executar a aplicacao!
    echo Verifique se o Java 21 esta instalado.
    echo.
    pause
    exit /b 1
)
