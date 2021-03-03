### CHECK LATEST VERSIONS OF TOMCAT AND OPENSSL ###
 
$tomcat9_version = "9.0.43"
$openssl_version = "1.1.1j"


### SSL CONFIGURATION ###
 
$ssl_host = "thingworx" # host name of ThingWorx server
$ssl_country = "IT" # 2-letter country code
$ssl_org = "your-organization"
$ssl_days = 365 # days of validity of certificate


### NO NEED TO CHANGE BELOW ###

# Copy files from the staging folder
Copy-Item staging\*.war tomcat\webapps -force
Copy-Item staging\*.bin thingworx -force


# Latest version of Amazon Corretto 11
$jdk_url="https://corretto.aws/downloads/latest/amazon-corretto-11-x64-windows-jdk.zip"


# Apache Tomcat download URL
$tomcat9_url="https://downloads.apache.org/tomcat/tomcat-9/v${tomcat9_version}/bin/apache-tomcat-${tomcat9_version}-windows-x64.zip"


# OpenSSL URL
# Note: the URL below is HTTP not HTTPS 
# However you can/should verify its authenticity by checking the digital signature of openssl.exe
# according to http://wiki.overbyte.eu/wiki/index.php/ICS_Download
$openssl_url = "http://wiki.overbyte.eu/arch/openssl-${openssl_version}-win64.zip"


# Download Java 11
Invoke-WebRequest -Uri $jdk_url -OutFile jdk.zip #
Expand-Archive jdk.zip -DestinationPath . #
Remove-Item jdk.zip #
$jdk_folder = Resolve-Path -Path (Get-ChildItem -Path . -Filter "jdk*").Name
$jdk_base_folder = (Get-ChildItem -Path . -Filter "jdk*").Name


# Download Tomcat9
Invoke-WebRequest -Uri $tomcat9_url -OutFile tomcat.zip #
Expand-Archive tomcat.zip -DestinationPath . #
Remove-Item tomcat.zip #
$tomcat_folder = Resolve-Path -Path (Get-ChildItem -Path . -Filter "apache*").Name


# Download OpenSSL
Invoke-WebRequest -Uri $openssl_url -OutFile openssl.zip #
Expand-Archive openssl.zip -DestinationPath openssl #
Remove-Item openssl.zip #
Write-Output "Verify the authenticity of $pwd\openssl\openssl.exe by ensuring it is digitally signed by François PIETTE, then press ENTER to continue"
Pause


# Create key and certificate
Push-Location openssl
& ".\openssl.exe" genpkey -algorithm RSA -out thingworx.key -pkeyopt rsa_keygen_bits:2048
& ".\openssl.exe" rsa -pubout -in thingworx.key -out thingworx.pub
& ".\openssl.exe" req -x509 -key thingworx.key -out thingworx.crt -days $ssl_days -subj "/C=$ssl_country/O=$ssl_org/CN=$ssl_host" -addext "subjectAltName=DNS:$ssl_host"
Pop-Location


# Generate batch file to run ThingWorx from a Command Prompt console
$thingWorx_batch = @"
@echo off
set JAVA_HOME=$($jdk_folder)
set CATALINA_HOME=$($tomcat_folder)
set CATALINA_BASE=%cd%\tomcat
set THINGWORX_PLATFORM_SETTINGS=%cd%\thingworx
pushd %THINGWORX_PLATFORM_SETTINGS%
call %CATALINA_HOME%\bin\catalina.bat run
popd
"@ | Out-File console-start-thingworx.bat


# Generate PowerShell script to run ThingWorx from a PowerShell console
$thingWorx_ps1 = @"
`$catalina_home = "`$pwd\apache-tomcat-$tomcat9_version"
`$thingworx_platform_settings = "`$pwd\thingworx"

`$Env:JAVA_HOME = "`$pwd\$jdk_base_folder"
`$Env:CATALINA_HOME = "`$catalina_home"
`$Env:CATALINA_BASE = "`$pwd\tomcat"
`$Env:THINGWORX_PLATFORM_SETTINGS = "`$thingworx_platform_settings"

Push-Location `$thingworx_platform_settings
& `$catalina_home\bin\catalina.bat run
Pop-Location
"@ | Out-File console-start-thingworx.ps1

