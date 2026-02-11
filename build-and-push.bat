@echo off
echo ========================================
echo  Build e Push para GitHub
echo  Pertocheck502s v2.1.0
echo ========================================
echo.

echo Configuracao atual:
echo   Porta: COM4
echo   Baudrate: 2400 bps
echo.

echo [PASSO 1/2] Fazendo build do projeto...
echo.
call rebuild.bat
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERRO no build! Corrija os erros antes de continuar.
    pause
    exit /b 1
)

echo.
echo ========================================
echo  Build concluido com sucesso!
echo ========================================
echo.

echo [PASSO 2/2] Enviando para GitHub...
echo.
call git-push.bat

echo.
echo ========================================
echo  Processo Concluido!
echo ========================================
pause
