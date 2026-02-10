[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=1
UseLongFileName=1
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=N
InstallPrompt=%InstallPrompt%
DisplayLicense=%DisplayLicense%
FinishMessage=%FinishMessage%
TargetName=%TargetName%
FriendlyName=%FriendlyName%
AppLaunched=%AppLaunched%
PostInstallCmd=%PostInstallCmd%
AdminQuietInstCmd=%AdminQuietInstCmd%
UserQuietInstCmd=%UserQuietInstCmd%
SourceFiles=SourceFiles

[Strings]
InstallPrompt=Deseja instalar o Pertocheck502s v2.1.0?
DisplayLicense=
FinishMessage=Instalacao concluida com sucesso!
TargetName=.\installer\Pertocheck502s-Setup-v2.1.0.exe
FriendlyName=Pertocheck502s 2.1.0
AppLaunched=cmd /c install.bat
PostInstallCmd=<None>
AdminQuietInstCmd=
UserQuietInstCmd=
FILE0="install.bat"
FILE1="README.md"
FILE2="Pertocheck502s.jar"
FILE3="icon2.ico"
FILE4="README.md"
FILE5="INICIO_RAPIDO.md"
FILE6="cheque_teste.txt"

[SourceFiles]
SourceFiles0=.\installer\
SourceFiles1=.\target\
SourceFiles2=.\Pertocheck502s\executavel\
SourceFiles3=.\
SourceFiles4=.\

[SourceFiles0]
%FILE0%=
%FILE1%=

[SourceFiles1]
%FILE2%=

[SourceFiles2]
%FILE3%=

[SourceFiles3]
%FILE4%=
%FILE5%=

[SourceFiles4]
%FILE6%=
