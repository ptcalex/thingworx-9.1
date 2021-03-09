### ENVIRONMENT DEFINITION ###

$java_home = "$pwd\jdk11.0.10_9"
$tomcat_version = "9.0.43"
$tomcat_shutdown_port = 8005
$tomcat_http_port = 8080
$tomcat_https_port = 8443
$tomcat_certificate_file = "$pwd\openssl\thingworx.crt" # no need to change
$tomcat_key_file = "$pwd\openssl\thingworx.key" # no need to change


#### NO NEED TO CHANGE BELOW ###

$default_service_name = "Tomcat9"
$service_name = "$default_service_name"
$catalina_home = "$pwd\apache-tomcat-$tomcat_version"
$catalina_base = "$pwd\tomcat"
$classpath = "$catalina_home\bin\bootstrap.jar;$catalina_home\bin\tomcat-juli.jar"
$executable = "$catalina_home\bin\$service_name.exe"


### INSTALL TOMCAT SERVICE ###
& $executable //IS//$service_name `
  --Description "Apache Tomcat for ThingWorx 9.1" `
  --DisplayName "ThingWorx Foundation 9.1" `
  --Install "$executable" `
  --Startup auto `
  --Environment "THINGWORX_PLATFORM_SETTINGS=$pwd\thingworx" `
  --JavaHome "$java_home" `
  --Jvm "$java_home\bin\server\jvm.dll" `
  --LogPath "$catalina_base\logs" `
  --StdOutput auto `
  --StdError auto `
  --Classpath "$classpath" `
  --StartMode jvm `
  --StopMode jvm `
  --StartPath "$pwd\thingworx" `
  --StopPath "$pwd\thingworx" `
  --StartClass org.apache.catalina.startup.Bootstrap `
  --StopClass org.apache.catalina.startup.Bootstrap `
  --StartParams start `
  --StopParams stop `
  --JvmOptions "-Dcatalina.home=$catalina_home;-Dcatalina.base=$catalina_base;-Djava.io.tmpdir=$catalina_base\temp;-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager;-Djava.util.logging.config.file=$catalina_base\conf\logging.properties;-Dserver;-Dd64;-XX:+UseG1GC;-Dfile.encoding=UTF-8;-Djava.library.path=$catalina_base\webapps\Thingworx\WEB-INF\extensions;-Djava.timezone=UTC;-Dshutdown.port=$tomcat_shutdown_port;-Dhttp.port=$tomcat_http_port;-Dhttps.port=$tomcat_https_port;-Dcertificate.file=$tomcat_certificate_file;-Dkey.file=$tomcat_key_file" `
  --JvmOptions9 "--add-opens=java.base/java.lang=ALL-UNNAMED#--add-opens=java.base/java.io=ALL-UNNAMED#--add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED" `
  --JvmMs "4G" `
  --JvmMx "16G"

if ($?) {
  Write-Output "The $service_name service has been installed"
} else {
  Write-Output "Failed installing $service_name service"
}

