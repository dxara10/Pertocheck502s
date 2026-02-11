@echo off
echo ========================================
echo  Compilacao Rapida - Pertocheck502s
echo ========================================
echo.

echo Compilando e gerando JAR...
call mvn clean package -DskipTests -q

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERRO na compilacao!
    echo Tentando com output completo...
    call mvn clean package -DskipTests
    pause
    exit /b 1
)

echo.
echo ========================================
echo  COMPILACAO CONCLUIDA!
echo ========================================
echo.
echo JAR gerado: target\Pertocheck502s.jar
echo.
echo Para executar:
echo   run.bat           - Interface grafica
echo   run-api.bat       - API REST
echo   listar-portas.bat - Ver portas COM
echo.
