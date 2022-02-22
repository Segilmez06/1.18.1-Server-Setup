$eulaStr = "eula=true"
$launchStr = "jdk-17.0.2\bin\java.exe -jar server.jar"

Clear-Host
Write-Host "Vanilla Minecraft 1.18.1 Server Setup Script"
Write-host "by Segilmez06"
Write-Host ""

Write-Host "You need to accept the EULA before installing server."
Write-Host "Read EULA at https://account.mojang.com/documents/minecraft_eula"
$la = Read-Host "Do you accept it? (Yes/No)"

if ($la -ne "Yes") {
	Write-Host "Setup aborted"
	exit
}

Write-Host ""

Write-Host "Creating server folder"
New-Item -ItemType directory server | Out-Null

Write-Host "Entering server folder"
Set-location server

Write-Host "Downloading runtime archive"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri https://download.oracle.com/java/17/archive/jdk-17.0.2_windows-x64_bin.zip -OutFile jdk.zip

Write-Host "Extracting runtime"
$ProgressPreference = 'SilentlyContinue'
tar -xf jdk.zip

Write-Host "Downloading server"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar -OutFile server.jar

Write-Host "Accepting EULA"
New-Item eula.txt | Out-Null
Out-File -FilePath eula.txt -InputObject $eulaStr

Write-Host "Creating starter script"
New-Item Start_Server.cmd | Out-Null
Out-File -FilePath Start_Server.cmd -InputObject $launchStr

Write-Host "Leaving server folder"
Set-Location ..
Write-Host "Completed! Use Start_Server.cmd to launch the server."
