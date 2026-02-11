@echo off
echo ========================================
echo  Pertocheck502s - Portas Disponiveis
echo ========================================
echo.

if not exist "target\Pertocheck502s.jar" (
    echo ERRO: JAR nao encontrado!
    echo Execute primeiro: build.bat
    pause
    exit /b 1
)

java -jar target\Pertocheck502s.jar --portas

echo.
pause
