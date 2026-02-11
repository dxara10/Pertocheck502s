@echo off
echo ========================================
echo  Pertocheck502s - Build e Run API
echo ========================================
echo.

echo [1/2] Compilando projeto...
call mvn clean package -DskipTests -q

if %ERRORLEVEL% NEQ 0 (
    echo ERRO na compilacao!
    pause
    exit /b 1
)

echo [2/2] Iniciando API REST...
echo.
echo API disponivel em: http://localhost:9090
echo Pressione Ctrl+C para parar
echo.

java -jar target\Pertocheck502s.jar --api 9090
