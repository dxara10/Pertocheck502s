@echo off
echo ========================================
echo  Pertocheck502s - Gerador de Instalador
echo  Versao 2.1.0 (usando jpackage)
echo ========================================
echo.

echo [1/3] Verificando Java 21...
java -version 2>&1 | findstr "21" >nul
if %ERRORLEVEL% NEQ 0 (
    echo ERRO: Java 21 nao encontrado!
    pause
    exit /b 1
)
echo OK!

echo.
echo [2/3] Verificando JAR...
if not exist "target\Pertocheck502s.jar" (
    echo ERRO: JAR nao encontrado!
    echo Execute primeiro: build.bat
    pause
    exit /b 1
)
echo OK!

echo.
echo [3/3] Gerando instalador Windows...
mkdir installer 2>nul

jpackage ^
  --input target ^
  --name "Pertocheck502s" ^
  --main-jar Pertocheck502s.jar ^
  --main-class visualizacao.JFramePrincipal ^
  --type msi ^
  --dest installer ^
  --app-version 2.1.0 ^
  --vendor "Flex Sistemas" ^
  --description "Impressora de Cheques Perto Check 502S" ^
  --icon Pertocheck502s\executavel\icon2.ico ^
  --win-dir-chooser ^
  --win-menu ^
  --win-shortcut ^
  --win-menu-group "Pertocheck502s"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERRO: Falha ao gerar instalador
    echo.
    echo NOTA: jpackage requer WiX Toolset para gerar MSI
    echo Baixe em: https://wixtoolset.org/
    echo.
    echo Alternativa: Use o instalador EXE simples (build-installer-simple.bat)
    pause
    exit /b 1
)

echo.
echo ========================================
echo  INSTALADOR CRIADO COM SUCESSO!
echo ========================================
echo.
dir /b installer\*.msi
echo.
pause
