@echo off
echo ========================================
echo  Teste de Diagnostico - Pertocheck502s
echo ========================================
echo.

echo [1] Verificando Java...
java -version
if %ERRORLEVEL% NEQ 0 (
    echo ERRO: Java nao encontrado!
    echo Instale Java 21 ou superior
    pause
    exit /b 1
)
echo OK
echo.

echo [2] Verificando Maven...
call mvn -version
if %ERRORLEVEL% NEQ 0 (
    echo AVISO: Maven nao encontrado!
    echo Necessario para compilar o projeto
)
echo.

echo [3] Verificando JAR...
if exist "target\Pertocheck502s.jar" (
    echo OK - JAR encontrado
    dir target\Pertocheck502s.jar | find "Pertocheck502s.jar"
) else (
    echo ERRO: JAR nao encontrado!
    echo Execute: build.bat ou build-fast.bat
)
echo.

echo [4] Verificando config.txt...
if exist "config.txt" (
    echo OK - Arquivo de configuracao encontrado
    type config.txt
) else (
    echo AVISO: config.txt nao encontrado!
    echo Crie o arquivo com:
    echo   COM1
    echo   9600
)
echo.

echo [5] Testando JAR (help)...
if exist "target\Pertocheck502s.jar" (
    java -jar target\Pertocheck502s.jar --help
)
echo.

echo ========================================
echo  Diagnostico Concluido
echo ========================================
pause
