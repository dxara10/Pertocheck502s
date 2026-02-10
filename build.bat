@echo off
echo ========================================
echo  Pertocheck502s - Build Script
echo  Versao 2.1.0
echo ========================================
echo.

echo [1/3] Limpando build anterior...
call mvn clean
if %ERRORLEVEL% NEQ 0 (
    echo ERRO: Falha ao limpar build anterior
    pause
    exit /b 1
)

echo.
echo [2/3] Compilando projeto...
call mvn compile
if %ERRORLEVEL% NEQ 0 (
    echo ERRO: Falha na compilacao
    pause
    exit /b 1
)

echo.
echo [3/3] Gerando JAR executavel...
call mvn package
if %ERRORLEVEL% NEQ 0 (
    echo ERRO: Falha ao gerar JAR
    pause
    exit /b 1
)

echo.
echo ========================================
echo  BUILD CONCLUIDO COM SUCESSO!
echo ========================================
echo.
echo Arquivo gerado: target\Pertocheck502s.jar
echo.
echo Para executar:
echo   java -jar target\Pertocheck502s.jar
echo.
pause
