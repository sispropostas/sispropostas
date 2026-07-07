@echo off
chcp 65001 >nul
setlocal

set "https://drive.google.com/file/d/1ILJboDhPtZfuC4u3-42mqVtZ7utrvFja/view?usp=sharing"
set "DEST_DIR=C:\Sispropostas"
set "DEST_FILE=%DEST_DIR%\Sispropostas.html"

echo ============================================
echo   Instalando SISpropostas...
echo ============================================
echo.

if not exist "%DEST_DIR%" (
    mkdir "%DEST_DIR%"
)

echo Baixando o arquivo do OneDrive...
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri '%URL%' -OutFile '%DEST_FILE%' -UseBasicParsing } catch { exit 1 }"

if not exist "%DEST_FILE%" (
    echo.
    echo ERRO: nao foi possivel baixar o arquivo.
    echo Verifique sua conexao com a internet ou se voce esta logado na sua conta corporativa.
    echo.
    pause
    exit /b 1
)

echo Arquivo baixado com sucesso.
echo.
echo Criando atalho na area de trabalho...

powershell -NoProfile -ExecutionPolicy Bypass -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\SISpropostas.lnk'); $Shortcut.TargetPath = '%DEST_FILE%'; $Shortcut.IconLocation = '%DEST_FILE%'; $Shortcut.Save()"

echo Atalho criado com sucesso.
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Sispropostas instalado com sucesso, um atalho foi criado na sua area de trabalho','SISpropostas',[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)"

endlocal
