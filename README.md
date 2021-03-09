# What is this about?

I am providing you with this Windows PowerShell-based artifact to simplify ThingWorx 9.1 installations on Windows.
The result is intended as a development environment.

This artifact neither includes a ThingWorx license (which you have to provide) nor the ThingWorx archive (which you have to download from [support.ptc.com](https://support.ptc.com/appserver/auth/it/esd/product.jsp?prodFamily=TWX)). It also does not include the DB scripts available as part of the ThingWorx installation and that you have to provide.


# How to use this artifact

This artifact allows to install ThingWorx with all related dependencies:
- as a Command Prompt application (you can start ThingWorx by running a batch file and stop it with Control-C)
- as a Windows service (you can start and stop ThingWorx from the Windows Services panel)

First of all you have to update the scripts described below (you will find details in the next sections):
- `thingworx-provision.ps1`
- `service-install.ps1`
- `service-remove.ps1`
Then you have to change the default passwords provided in the `platform-settings.json` file.

Before running the scripts you have to tailor them to your environment. They include a section that provides variable that you can configure.


# Update the provisioning script

Edit `thingworx-provision.ps1`:
- Update the Tomcat9 version to the [latest version](https://tomcat.apache.org/download-90.cgi)
- Update the OpenSSL version to the [latest version](http://wiki.overbyte.eu/wiki/index.php/ICS_Download#Download_OpenSSL_Binaries_.28required_for_SSL-enabled_components.29)
- Tailor the SSL CONFIGURATION to your environemnt by setting the host name, a 2-letter country code, the name of your organization and the certificate validity in days.

Stage files in the staging folder:
- `Thingworx.war`: bring your own ThingWorx
- DB installation scripts: the `install` folder that is part of the ThingWorx installation files


# Update the service installer and removal scripts

Edit `service-install.ps1`:
- Update the ENVIRONMENT DEFINITION section (Java home, Tomcat versions, etc.)
- Update Apache Tomcat ports, certificate and key files

Edit `service-remove.ps1`:
- Update Apache Tomcat version


# Update the DB scripts launcher

You need to do this if the DB is not H2.
The DB scripts launcher the batch file `pg-install.bat` located in `thingworx\install`.


# Run the scripts

Open an Administrative PowerShell console and run:
- `thingworx-provision.ps1`
- `service-install.ps1` if you intend to install ThingWor as a Windows service


# Start ThingWorx

Get the license ID from Application.log, request a license from [PTC License Support](https://support.ptc.com/apps/licensePortal/auth/ssl/index), rename it to `license_capability_response.bin` and copy it to the `thingworx` folder.

