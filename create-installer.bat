@echo off
echo ========================================
echo  Criando Instalador Executavel
echo  Pertocheck502s v2.1.0
echo ========================================
echo.

echo [1/3] Verificando arquivos necessarios...
if not exist "target\Pertocheck502s.jar" (
    echo ERRO: JAR nao encontrado!
    echo Execute primeiro: build.bat
    pause
    exit /b 1
)
echo OK!

echo.
echo [2/3] Preparando arquivos...
mkdir installer\temp 2>nul
copy /Y installer\install.bat installer\temp\ >nul
copy /Y installer\README.md installer\temp\ >nul
copy /Y target\Pertocheck502s.jar installer\temp\ >nul
copy /Y Pertocheck502s\executavel\icon2.ico installer\temp\ >nul
copy /Y README.md installer\temp\ >nul
copy /Y INICIO_RAPIDO.md installer\temp\ >nul
copy /Y cheque_teste.txt installer\temp\ >nul
echo OK!

echo.
echo [3/3] Criando executavel auto-extraivel...

REM Cria arquivo SED para IExpress
echo [Version]> installer\temp\config.sed
echo Class=IEXPRESS>> installer\temp\config.sed
echo SEDVersion=3>> installer\temp\config.sed
echo [Options]>> installer\temp\config.sed
echo PackagePurpose=InstallApp>> installer\temp\config.sed
echo ShowInstallProgramWindow=0>> installer\temp\config.sed
echo HideExtractAnimation=0>> installer\temp\config.sed
echo UseLongFileName=1>> installer\temp\config.sed
echo InsideCompressed=0>> installer\temp\config.sed
echo CAB_FixedSize=0>> installer\temp\config.sed
echo CAB_ResvCodeSigning=0>> installer\temp\config.sed
echo RebootMode=N>> installer\temp\config.sed
echo InstallPrompt=Deseja instalar o Pertocheck502s v2.1.0?>> installer\temp\config.sed
echo DisplayLicense=>> installer\temp\config.sed
echo FinishMessage=Instalacao concluida! Execute pelo Menu Iniciar.>> installer\temp\config.sed
echo TargetName=%CD%\installer\Pertocheck502s-Setup-v2.1.0.exe>> installer\temp\config.sed
echo FriendlyName=Pertocheck502s 2.1.0 - Impressora de Cheques>> installer\temp\config.sed
echo AppLaunched=cmd /c install.bat>> installer\temp\config.sed
echo PostInstallCmd=^<None^>>> installer\temp\config.sed
echo AdminQuietInstCmd=>> installer\temp\config.sed
echo UserQuietInstCmd=>> installer\temp\config.sed
echo FILE0="install.bat">> installer\temp\config.sed
echo FILE1="Pertocheck502s.jar">> installer\temp\config.sed
echo FILE2="icon2.ico">> installer\temp\config.sed
echo FILE3="README.md">> installer\temp\config.sed
echo FILE4="INICIO_RAPIDO.md">> installer\temp\config.sed
echo FILE5="cheque_teste.txt">> installer\temp\config.sed
echo [Strings]>> installer\temp\config.sed
echo [SourceFiles]>> installer\temp\config.sed
echo SourceFiles0=%CD%\installer\temp\>> installer\temp\config.sed
echo [SourceFiles0]>> installer\temp\config.sed
echo %%FILE0%%=>> installer\temp\config.sed
echo %%FILE1%%=>> installer\temp\config.sed
echo %%FILE2%%=>> installer\temp\config.sed
echo %%FILE3%%=>> installer\temp\config.sed
echo %%FILE4%%=>> installer\temp\config.sed
echo %%FILE5%%=>> installer\temp\config.sed

REM Executa IExpress
iexpress /N /Q installer\temp\config.sed

if %ERRORLEVEL% NEQ 0 (
    echo ERRO: Falha ao criar executavel
    pause
    exit /b 1
)

REM Limpa arquivos temporarios
rmdir /s /q installer\temp

echo OK!
echo.
echo ========================================
echo  INSTALADOR CRIADO COM SUCESSO!
echo ========================================
echo.
echo Arquivo: installer\Pertocheck502s-Setup-v2.1.0.exe
echo Tamanho: 
dir /b installer\Pertocheck502s-Setup-v2.1.0.exe 2>nul
echo.
echo Para instalar:
echo 1. Execute o arquivo .exe como administrador
echo 2. Siga as instrucoes na tela
echo 3. Pronto!
echo.
pause
