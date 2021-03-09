### TAILORING SECTION ###

# Tailor versions of software dependencies
$tomcat9_version = "9.0.43"
$openssl_version = "1.1.1j"

# Tailor SSL configuration 
$ssl_host = "thingworx" # host name of ThingWorx server
$ssl_country = "IT" # 2-letter country code
$ssl_org = "PTC"
$ssl_days = 365 # days of validity of certificate



### NO NEED TO CHANGE BELOW THIS LINE ###

# Copy files from the staging folder
Copy-Item -Path "staging\*.war" -Destination "tomcat\webapps" -Force
Copy-Item -Path "staging\install" -Destination "thingworx" -Force -Recurse
$pg_install_exists = Test-Path -Path "thingworx\install\pg-install.bat" -PathType Leaf
if ($pg_install_exists -eq $False) {
  Copy-Item -Path "staging\etc\pg-install.bat" -Destination "thingworx\install" -Force
}


# Latest version of Amazon Corretto 11
$jdk_url="https://corretto.aws/downloads/latest/amazon-corretto-11-x64-windows-jdk.zip"


# Apache Tomcat download URL
$tomcat9_url="https://downloads.apache.org/tomcat/tomcat-9/v${tomcat9_version}/bin/apache-tomcat-${tomcat9_version}-windows-x64.zip"


# OpenSSL URL
# Note: the URL below is HTTP not HTTPS 
# However you can/should verify its authenticity by checking the digital signature of openssl.exe
# according to http://wiki.overbyte.eu/wiki/index.php/ICS_Download
$openssl_url = "http://wiki.overbyte.eu/arch/openssl-${openssl_version}-win64.zip"


# Download Java
$jdk_exists = Test-Path -Path "jdk*" -PathType Container
if ($jdk_exist -eq $False) {
  Write-Output "Downloading and installing Java..."
  Invoke-WebRequest -Uri "${jdk_url}" -OutFile "jdk.zip"
  Expand-Archive "jdk.zip" -DestinationPath .
  Remove-Item "jdk.zip"
} else {
  Write-Output "Java already installed, skipping..."
}
$jdk_folder = Resolve-Path -Path (Get-ChildItem -Path . -Filter "jdk*")[0].Name


# Download Apache Tomcat
$tomcat_exists = Test-Path -Path "apache-tomcat-*" -PathType Container
if ($tomcat_exists -eq $False) {
  Write-Output "Downloading Apache Tomcat..."
  Invoke-WebRequest -Uri "${tomcat9_url}" -OutFile "tomcat.zip"
  Expand-Archive "tomcat.zip" -DestinationPath .
  Remove-Item "tomcat.zip"
} else {
  Write-Output "Apache Tomcat already downloaded, skipping..."
}
$tomcat_folder = Resolve-Path -Path (Get-ChildItem -Path . -Filter "apache-tomcat-*")[0].Name


# Download OpenSSL
$openssl_exists = Test-Path -Path "openssl*" -PathType Container
if ($openssl_exists -eq $False) {
  Write-Output "Downloading and installing OpenSSL..."
  Invoke-WebRequest -Uri "${openssl_url}" -OutFile "openssl.zip"
  Expand-Archive "openssl.zip" -DestinationPath "openssl"
  Remove-Item "openssl.zip"
  Write-Output "You must verify the Digital Signature of $pwd\openssl\openssl.exe..."
  Pause

  # Deploy OpenSSL configuration file
  Copy-Item -Path "staging\etc\openssl.cnf" -Destination "openssl" -Force

  # Create key and certificate
  Push-Location "openssl"
  & ".\openssl.exe" genpkey -algorithm RSA -out thingworx.key -pkeyopt rsa_keygen_bits:2048
  & ".\openssl.exe" rsa -pubout -in thingworx.key -out thingworx.pub
  & ".\openssl.exe" req -x509 -key thingworx.key -out thingworx.crt -days $ssl_days -subj "/C=$ssl_country/O=$ssl_org/CN=$ssl_host" -addext "subjectAltName=DNS:$ssl_host" -config openssl.cnf
  Pop-Location
} else {
  Write-Output "OpenSSL already installed, skipping..."
}


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

Write-Output "console-start-thingworx.bat created."

Write-Output "DONE!"
