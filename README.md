# What is this about?

I am providing you this Windows PowerShell-based artifact to simplify ThingWorx 9.1 installations on Windows.
The result is intended as a development environment.

This artifact neither includes a ThingWorx license (which you have to provide) nor the ThingWorx archive (which you have to download from [support.ptc.com](https://support.ptc.com/appserver/auth/it/esd/product.jsp?prodFamily=TWX)). It also does not include the DB scripts available in the ThingWorx installation and that you have to provide.


# How to use this artifact

This artifact allows to install ThingWorx with all related dependencies:
- as a Command Prompt application (you can start by running a batch file and stop with Control-C)
- as a Windows service (you can start and stop from the Windows Services panel)

First of all you have to update the two scripts (as described below) to fine tune the versions of software dependencies and other minor details:
- `thingworx-provision.ps1`
- `service-install.ps1`
- `service-remove.ps1`

Then change the passwords in the `platform-settings.json` file.

Finally run the `thingworx-provision.ps1` script in a Administrative PowerShell console.

If you plan to install ThingWorx as a Windows service, also run `service-install.ps1` in an Administrative PowerShell console.

Before running the provisioning script, you *must* update the scripts, as described in the next sections.


# Update the provisioning script

Edit `thingworx-provision.ps1`:
- Update the Tomcat9 version to the [latest version](https://tomcat.apache.org/download-90.cgi)
- Update the OpenSSL version to the [latest version](http://wiki.overbyte.eu/wiki/index.php/ICS_Download#Download_OpenSSL_Binaries_.28required_for_SSL-enabled_components.29)
- Tailor the SSL CONFIGURATION to your environemnt by setting the host name, a 2-letter country code, the name of your organization and the certificate validity in days.

Stage files in the staging folder:
- `Thingworx.war`: bring your own ThingWorx
- License file: bring your own license
- DB installation scripts: the `install` folder that is part of the ThingWorx installation files


# Update the service installer and removal scripts

Edit `service-install.ps1`:
- Update the ENVIRONMENT DEFINITION section (Java home, Tomcat versions, etc.)
- Update Apache Tomcat ports, certificate and key files

Edit `service-remove.ps1`:
- Update Apache Tomcat version


# Update the DB scripts launcher if using a DB that is not H2

The DB scripts launcher is PowerShell script `pg-install.ps1` located in `thingworx\install`.

