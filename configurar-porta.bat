@echo off
setlocal enabledelayedexpansion

echo ========================================
echo  Configurador de Porta - Pertocheck502s
echo ========================================
echo.

if not exist "target\Pertocheck502s.jar" (
    echo ERRO: JAR nao encontrado!
    echo Execute primeiro: build-fast.bat
    pause
    exit /b 1
)

echo Detectando portas seriais disponiveis...
echo.

java -jar target\Pertocheck502s.jar --portas > portas_temp.txt 2>&1

type portas_temp.txt
echo.

echo ========================================
echo  Configuracao Atual
echo ========================================
if exist "config.txt" (
    findstr /B "PORTA=" config.txt
    findstr /B "BITS_PER_SECOND=" config.txt
) else (
    echo Arquivo config.txt nao encontrado!
)
echo.

echo ========================================
echo  Opcoes de Configuracao
echo ========================================
echo.
echo 1. Usar COM1 (9600 bps)
echo 2. Usar COM2 (9600 bps)
echo 3. Usar COM3 (9600 bps)
echo 4. Usar COM4 (9600 bps)
echo 5. Configuracao manual
echo 0. Sair
echo.

set /p opcao="Escolha uma opcao: "

if "%opcao%"=="1" (
    call :configurar COM1 9600
) else if "%opcao%"=="2" (
    call :configurar COM2 9600
) else if "%opcao%"=="3" (
    call :configurar COM3 9600
) else if "%opcao%"=="4" (
    call :configurar COM4 9600
) else if "%opcao%"=="5" (
    call :configurar_manual
) else if "%opcao%"=="0" (
    goto :fim
) else (
    echo Opcao invalida!
    pause
    goto :fim
)

:testar
echo.
echo Deseja testar a conexao agora? (S/N)
set /p testar="Resposta: "
if /i "%testar%"=="S" (
    echo.
    echo Testando conexao...
    echo.
    java -jar target\Pertocheck502s.jar --api 9090
)
goto :fim

:configurar
echo.
echo Configurando porta %1 com %2 bps...
(
echo # Configuracao da Impressora Perto Check 502S
echo # Versao 2.1.0
echo.
echo # Porta Serial
echo PORTA=%1
echo.
echo # Taxa de transmissao em bits por segundo
echo BITS_PER_SECOND=%2
echo.
echo # Diretorio padrao para selecao de arquivos
echo DIRETORIO=
) > config.txt
echo.
echo Configuracao salva com sucesso!
echo Porta: %1
echo Baudrate: %2 bps
goto :testar

:configurar_manual
echo.
set /p porta="Digite a porta (ex: COM1): "
set /p baudrate="Digite o baudrate (ex: 9600): "
call :configurar %porta% %baudrate%
goto :eof

:fim
if exist "portas_temp.txt" del portas_temp.txt
echo.
pause
