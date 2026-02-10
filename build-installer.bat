@echo off
echo ========================================
echo  Pertocheck502s - Gerador de Instalador
echo  Versao 2.1.0
echo ========================================
echo.

REM Verifica se o Inno Setup esta instalado
set INNO_PATH=C:\Program Files (x86)\Inno Setup 6\ISCC.exe
if not exist "%INNO_PATH%" (
    set INNO_PATH=C:\Program Files\Inno Setup 6\ISCC.exe
)

if not exist "%INNO_PATH%" (
    echo ERRO: Inno Setup nao encontrado!
    echo.
    echo Por favor, instale o Inno Setup 6:
    echo https://jrsoftware.org/isdl.php
    echo.
    pause
    exit /b 1
)

echo [1/2] Verificando JAR...
if not exist "target\Pertocheck502s.jar" (
    echo ERRO: JAR nao encontrado!
    echo Execute primeiro: build.bat
    echo.
    pause
    exit /b 1
)
echo OK!

echo.
echo [2/2] Compilando instalador...
"%INNO_PATH%" installer.iss

if %ERRORLEVEL% NEQ 0 (
    echo ERRO: Falha ao compilar instalador
    pause
    exit /b 1
)

echo.
echo ========================================
echo  INSTALADOR CRIADO COM SUCESSO!
echo ========================================
echo.
echo Arquivo: installer\Pertocheck502s-Setup-v2.1.0.exe
echo.
pause
