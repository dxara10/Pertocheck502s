@echo off
echo ========================================
echo  Build Completo - Pertocheck502s
echo  COM4 @ 2400 bps
echo ========================================
echo.

REM Verifica se Maven está no PATH
where mvn >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Maven encontrado no PATH
    set MVN_CMD=mvn
    goto :build
)

REM Procura Maven em locais comuns
if exist "C:\Program Files\Apache\maven\bin\mvn.cmd" (
    echo Maven encontrado em C:\Program Files\Apache\maven
    set MVN_CMD="C:\Program Files\Apache\maven\bin\mvn.cmd"
    goto :build
)

if exist "C:\apache-maven\bin\mvn.cmd" (
    echo Maven encontrado em C:\apache-maven
    set MVN_CMD="C:\apache-maven\bin\mvn.cmd"
    goto :build
)

if exist "%USERPROFILE%\apache-maven\bin\mvn.cmd" (
    echo Maven encontrado em %USERPROFILE%\apache-maven
    set MVN_CMD="%USERPROFILE%\apache-maven\bin\mvn.cmd"
    goto :build
)

echo ERRO: Maven nao encontrado!
echo.
echo Instale o Maven ou adicione ao PATH
echo Download: https://maven.apache.org/download.cgi
echo.
pause
exit /b 1

:build
echo.
echo [1/3] Limpando build anterior...
call %MVN_CMD% clean
if %ERRORLEVEL% NEQ 0 goto :erro

echo.
echo [2/3] Compilando projeto...
call %MVN_CMD% compile
if %ERRORLEVEL% NEQ 0 goto :erro

echo.
echo [3/3] Gerando JAR...
call %MVN_CMD% package -DskipTests
if %ERRORLEVEL% NEQ 0 goto :erro

echo.
echo ========================================
echo  BUILD CONCLUIDO!
echo ========================================
echo.
echo Configuracao: COM4 @ 2400 bps
echo JAR: target\Pertocheck502s.jar
echo.
echo Para executar:
echo   run-api.bat
echo.
goto :fim

:erro
echo.
echo ========================================
echo  ERRO NO BUILD!
echo ========================================
pause
exit /b 1

:fim
