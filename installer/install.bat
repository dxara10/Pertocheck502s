@echo off
setlocal enabledelayedexpansion

echo ========================================
echo  INSTALADOR - Pertocheck502s v2.1.0
echo  Impressora de Cheques Perto Check 502S
echo ========================================
echo.

REM Verifica se esta executando como administrador
net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Este instalador requer privilegios de administrador.
    echo Clique com botao direito e selecione "Executar como administrador"
    echo.
    pause
    exit /b 1
)

echo [1/5] Verificando Java...
java -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo AVISO: Java nao detectado no sistema!
    echo.
    echo O Pertocheck502s requer Java 21 ou superior.
    echo Baixe em: https://adoptium.net/
    echo.
    set /p CONTINUAR="Deseja continuar mesmo assim? (S/N): "
    if /i "!CONTINUAR!" NEQ "S" exit /b 1
) else (
    echo OK!
)

echo.
echo [2/5] Definindo diretorio de instalacao...
set "INSTALL_DIR=%ProgramFiles%\Pertocheck502s"
echo Diretorio: %INSTALL_DIR%

echo.
echo [3/5] Criando diretorios...
mkdir "%INSTALL_DIR%" 2>nul
mkdir "%INSTALL_DIR%\docs" 2>nul
mkdir "%INSTALL_DIR%\exemplos" 2>nul
mkdir "%ProgramData%\Pertocheck502s" 2>nul
echo OK!

echo.
echo [4/5] Copiando arquivos...
copy /Y "Pertocheck502s.jar" "%INSTALL_DIR%\" >nul
copy /Y "icon2.ico" "%INSTALL_DIR%\" >nul
copy /Y "README.md" "%INSTALL_DIR%\docs\" >nul
copy /Y "INICIO_RAPIDO.md" "%INSTALL_DIR%\docs\" >nul
copy /Y "GUIA_PHP.md" "%INSTALL_DIR%\docs\" >nul
copy /Y "cheque_teste.txt" "%INSTALL_DIR%\exemplos\" >nul

REM Cria arquivo de configuracao se nao existir
if not exist "%ProgramData%\Pertocheck502s\config.txt" (
    echo PORTA=COM1> "%ProgramData%\Pertocheck502s\config.txt"
    echo BITS_PER_SECOND=9600>> "%ProgramData%\Pertocheck502s\config.txt"
    echo DIRETORIO=%USERPROFILE%\Documents>> "%ProgramData%\Pertocheck502s\config.txt"
)

REM Cria link simbolico para config
mklink "%INSTALL_DIR%\config.txt" "%ProgramData%\Pertocheck502s\config.txt" >nul 2>&1
echo OK!

echo.
echo [5/5] Criando atalhos...

REM Cria atalho no Menu Iniciar
set "START_MENU=%ProgramData%\Microsoft\Windows\Start Menu\Programs\Pertocheck502s"
mkdir "%START_MENU%" 2>nul

REM Cria script VBS para criar atalho
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%START_MENU%\Pertocheck502s.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "javaw.exe" >> CreateShortcut.vbs
echo oLink.Arguments = "-jar ""%INSTALL_DIR%\Pertocheck502s.jar""" >> CreateShortcut.vbs
echo oLink.WorkingDirectory = "%INSTALL_DIR%" >> CreateShortcut.vbs
echo oLink.IconLocation = "%INSTALL_DIR%\icon2.ico" >> CreateShortcut.vbs
echo oLink.Description = "Impressora de Cheques Perto Check 502S" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript //nologo CreateShortcut.vbs
del CreateShortcut.vbs

REM Atalho para configuracao
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%START_MENU%\Configuracao.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "notepad.exe" >> CreateShortcut.vbs
echo oLink.Arguments = """%ProgramData%\Pertocheck502s\config.txt""" >> CreateShortcut.vbs
echo oLink.Description = "Configurar Pertocheck502s" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript //nologo CreateShortcut.vbs
del CreateShortcut.vbs

REM Atalho na Area de Trabalho
set /p DESKTOP="Criar atalho na Area de Trabalho? (S/N): "
if /i "!DESKTOP!" EQU "S" (
    echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
    echo sLinkFile = "%PUBLIC%\Desktop\Pertocheck502s.lnk" >> CreateShortcut.vbs
    echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
    echo oLink.TargetPath = "javaw.exe" >> CreateShortcut.vbs
    echo oLink.Arguments = "-jar ""%INSTALL_DIR%\Pertocheck502s.jar""" >> CreateShortcut.vbs
    echo oLink.WorkingDirectory = "%INSTALL_DIR%" >> CreateShortcut.vbs
    echo oLink.IconLocation = "%INSTALL_DIR%\icon2.ico" >> CreateShortcut.vbs
    echo oLink.Description = "Impressora de Cheques Perto Check 502S" >> CreateShortcut.vbs
    echo oLink.Save >> CreateShortcut.vbs
    cscript //nologo CreateShortcut.vbs
    del CreateShortcut.vbs
)

echo OK!

REM Registra no Windows
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Pertocheck502s" /v "DisplayName" /t REG_SZ /d "Pertocheck502s 2.1.0" /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Pertocheck502s" /v "DisplayVersion" /t REG_SZ /d "2.1.0" /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Pertocheck502s" /v "Publisher" /t REG_SZ /d "Flex Sistemas" /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Pertocheck502s" /v "InstallLocation" /t REG_SZ /d "%INSTALL_DIR%" /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Pertocheck502s" /v "UninstallString" /t REG_SZ /d "%INSTALL_DIR%\uninstall.bat" /f >nul

REM Cria desinstalador
echo @echo off > "%INSTALL_DIR%\uninstall.bat"
echo echo Desinstalando Pertocheck502s... >> "%INSTALL_DIR%\uninstall.bat"
echo rmdir /s /q "%INSTALL_DIR%" >> "%INSTALL_DIR%\uninstall.bat"
echo rmdir /s /q "%ProgramData%\Pertocheck502s" >> "%INSTALL_DIR%\uninstall.bat"
echo rmdir /s /q "%START_MENU%" >> "%INSTALL_DIR%\uninstall.bat"
echo del "%PUBLIC%\Desktop\Pertocheck502s.lnk" 2^>nul >> "%INSTALL_DIR%\uninstall.bat"
echo reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Pertocheck502s" /f ^>nul >> "%INSTALL_DIR%\uninstall.bat"
echo echo Desinstalacao concluida! >> "%INSTALL_DIR%\uninstall.bat"
echo pause >> "%INSTALL_DIR%\uninstall.bat"

echo.
echo ========================================
echo  INSTALACAO CONCLUIDA COM SUCESSO!
echo ========================================
echo.
echo Instalado em: %INSTALL_DIR%
echo Configuracao: %ProgramData%\Pertocheck502s\config.txt
echo.
echo Para executar:
echo - Menu Iniciar ^> Pertocheck502s
echo - Ou execute: %INSTALL_DIR%\Pertocheck502s.jar
echo.
set /p EXECUTAR="Deseja executar agora? (S/N): "
if /i "!EXECUTAR!" EQU "S" (
    start javaw -jar "%INSTALL_DIR%\Pertocheck502s.jar"
)

echo.
pause
