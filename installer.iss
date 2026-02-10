#define MyAppName "Pertocheck 502S"
#define MyAppVersion "2.1.0"
#define MyAppPublisher "Flex Sistemas"
#define MyAppExeName "Pertocheck502s.exe"
#define MyAppJarName "Pertocheck502s.jar"

[Setup]
AppId={{8F9A2B3C-4D5E-6F7A-8B9C-0D1E2F3A4B5C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=installer
OutputBaseFilename=Pertocheck502s-Setup-v{#MyAppVersion}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
SetupIconFile=Pertocheck502s\executavel\icon2.ico
UninstallDisplayIcon={app}\{#MyAppExeName}

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "Criar atalho na Área de Trabalho"; GroupDescription: "Atalhos adicionais:"
Name: "quicklaunchicon"; Description: "Criar atalho na Barra de Tarefas"; GroupDescription: "Atalhos adicionais:"; Flags: unchecked

[Files]
Source: "target\{#MyAppJarName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "config.txt"; DestDir: "{commonappdata}\Pertocheck502s"; Flags: onlyifdoesntexist
Source: "cheque_teste.txt"; DestDir: "{app}\exemplos"; Flags: ignoreversion
Source: "README.md"; DestDir: "{app}\docs"; Flags: ignoreversion
Source: "INICIO_RAPIDO.md"; DestDir: "{app}\docs"; Flags: ignoreversion

[Dirs]
Name: "{commonappdata}\Pertocheck502s"; Permissions: users-full

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "javaw.exe"; Parameters: "-jar ""{app}\{#MyAppJarName}"""; WorkingDir: "{app}"; IconFilename: "{app}\icon2.ico"
Name: "{group}\Configuração"; Filename: "notepad.exe"; Parameters: """{commonappdata}\Pertocheck502s\config.txt"""
Name: "{group}\Documentação"; Filename: "{app}\docs"
Name: "{group}\Desinstalar {#MyAppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "javaw.exe"; Parameters: "-jar ""{app}\{#MyAppJarName}"""; WorkingDir: "{app}"; IconFilename: "{app}\icon2.ico"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "javaw.exe"; Parameters: "-jar ""{app}\{#MyAppJarName}"""; WorkingDir: "{app}"; IconFilename: "{app}\icon2.ico"; Tasks: quicklaunchicon

[Registry]
Root: HKLM; Subkey: "Software\{#MyAppPublisher}\{#MyAppName}"; ValueType: string; ValueName: "Version"; ValueData: "{#MyAppVersion}"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\{#MyAppPublisher}\{#MyAppName}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"

[Run]
Filename: "{app}\docs\README.md"; Description: "Ver documentação"; Flags: postinstall shellexec skipifsilent unchecked
Filename: "javaw.exe"; Parameters: "-jar ""{app}\{#MyAppJarName}"""; WorkingDir: "{app}"; Description: "Executar {#MyAppName}"; Flags: postinstall skipifsilent nowait

[Code]
function InitializeSetup(): Boolean;
var
  ResultCode: Integer;
  JavaInstalled: Boolean;
  JavaVersion: String;
begin
  Result := True;
  JavaInstalled := RegQueryStringValue(HKLM, 'SOFTWARE\JavaSoft\Java Runtime Environment', 'CurrentVersion', JavaVersion);
  
  if not JavaInstalled then
    JavaInstalled := RegQueryStringValue(HKLM64, 'SOFTWARE\JavaSoft\Java Runtime Environment', 'CurrentVersion', JavaVersion);
  
  if not JavaInstalled then
    JavaInstalled := RegQueryStringValue(HKLM, 'SOFTWARE\JavaSoft\JDK', 'CurrentVersion', JavaVersion);
    
  if not JavaInstalled then
    JavaInstalled := RegQueryStringValue(HKLM64, 'SOFTWARE\JavaSoft\JDK', 'CurrentVersion', JavaVersion);
  
  if not JavaInstalled then
  begin
    if MsgBox('Java 21 ou superior não foi detectado no sistema.' + #13#10 + 
              'O Pertocheck 502S requer Java para funcionar.' + #13#10#13#10 +
              'Deseja continuar mesmo assim?' + #13#10 +
              '(Você precisará instalar o Java manualmente)', 
              mbConfirmation, MB_YESNO) = IDNO then
    begin
      Result := False;
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ConfigFile: String;
begin
  if CurStep = ssPostInstall then
  begin
    ConfigFile := ExpandConstant('{commonappdata}\Pertocheck502s\config.txt');
    if not FileExists(ConfigFile) then
    begin
      SaveStringToFile(ConfigFile, 'PORTA=COM1' + #13#10, False);
      SaveStringToFile(ConfigFile, 'BITS_PER_SECOND=9600' + #13#10, True);
      SaveStringToFile(ConfigFile, 'DIRETORIO=' + ExpandConstant('{userdocs}') + #13#10, True);
    end;
  end;
end;

[UninstallDelete]
Type: filesandordirs; Name: "{commonappdata}\Pertocheck502s"
