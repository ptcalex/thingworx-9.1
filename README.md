# What is this about?

I am providing you with this Windows PowerShell-based artifact to simplify ThingWorx 9.1 installations on Windows.
The result is intended as a development environment.

This artifact neither includes a ThingWorx license (which you have to provide) nor the ThingWorx archive (which you have to download from [support.ptc.com](https://support.ptc.com/appserver/auth/it/esd/product.jsp?prodFamily=TWX)). It also does not include the DB scripts available as part of the ThingWorx installation and that you have to provide.


# How to use this artifact

This artifact allows to install ThingWorx with all related dependencies:
- as a Command Prompt application (you can start ThingWorx by running a batch file and stop it with Control-C)
- as a Windows service (you can start and stop ThingWorx from the Windows Services panel)

First of all you have to tailor the scripts described below (details in the next sections):
- `thingworx-provision.ps1`
- `service-install.ps1`
- `service-remove.ps1`

Then you have to change the default passwords in `thingworx\platform-settings.json`.

Before running the scripts you have to tailor them to your environment. They include a section that contains the variables that you can tailor.


# Tailor the provisioning script

Edit `thingworx-provision.ps1`:
- Update the Tomcat9 version to the [latest version](https://tomcat.apache.org/download-90.cgi)
- Update the OpenSSL version to the [latest version](http://wiki.overbyte.eu/wiki/index.php/ICS_Download#Download_OpenSSL_Binaries_.28required_for_SSL-enabled_components.29)
- Tailor the SSL CONFIGURATION to your environemnt by setting the host name, a 2-letter country code, the name of your organization and the certificate validity in days.

Stage files in the staging folder:
- `Thingworx.war`: bring your own ThingWorx
- DB installation scripts: the `install` folder that is part of ThingWorx installation


# Tailor the service install and remove scripts

Edit `service-install.ps1`:
- Update the ENVIRONMENT DEFINITION section (Java home, Tomcat versions, etc.)
- Update Apache Tomcat ports, certificate and key files

Edit `service-remove.ps1`:
- Update Apache Tomcat version


# Run the provisioning script

Open an Administrative PowerShell console and run `.\thingworx-provision.ps1`.


# Tailor and run the PostgreSQL DB script

The DB script is: `thingworx\install\pg-install.bat`.
The settings to tailor are in the top section.
After tailoring, but before running the script, make sure that the DB client is in the PATH (for PostgreSQL this is the PostgreSQL `bin` folder).
Run the script in a Command Prompt window, or just double-click on it in the Windows Explorer.


# Start ThingWorx

Start ThingWorx without a license by running the generated `console-start-thingworx.bat` batch file.

Get the license ID from the generated file `thingworx\licenseRequestFile.txt` or from `Application.log`, request a license from [PTC License Support](https://support.ptc.com/apps/licensePortal/auth/ssl/index), rename it to `license_capability_response.bin` and copy the file to the `thingworx` folder.


# Install ThingWorx as a Windows service

Run `.\service-install.ps1` if you intend to install ThingWorx as a Windows service.

