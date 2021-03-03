### TOMCAT VERSION ###

$tomcat_version = "9.0.43"


### NO NEED TO CHANGE BELOW ###

$catalina_home = "$pwd\apache-tomcat-$tomcat_version"
$service_name = "Tomcat9"

& "$catalina_home\bin\$service_name.exe" //DS//$service_name
