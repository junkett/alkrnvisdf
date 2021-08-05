$ErrorActionPreference = "SilentlyContinue"
$WarningActionPreference = "SilentlyContinue"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco install git brave vscode totalcommander 7zip wget curl cmder sysinternals pwsh gcloudsdk -y
install-windowsfeature telnet-client

wget "https://github.com/GoogleCloudPlatform/iap-desktop/releases/latest/download/IapDesktop.msi" -OutFile ".\IapDesktop.msi"

# Install Az Cli
wget "https://aka.ms/installazurecliwindows" -OutFile .\AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'
rm .\AzureCLI.msi

# Install Az module for PWSH
Install-Module Az -Confirm:$false -Force

# Join domain
$domain = "bartpdav.local"
$password = "YAQ123edc" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\tea" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName bartpdav.local -Server bartpdav-dev-w1.bartpdav.local -OUPath "OU=Servers,OU=Tieto,DC=bartpdav,DC=local" -Credential $credential
Restart-Computer
