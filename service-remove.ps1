### NO NEED TO CHANGE THIS FILE ###

$catalina_home = (Get-ChildItem -Path . -Filter "apache-tomcat-*")[0].Name
$service_name = "Tomcat9"

& "${catalina_home}\bin\${service_name}.exe" //DS//$service_name
