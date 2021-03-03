# What is this about?

I am providing this Windows PowerShell-based artifact to simplify ThingWorx 9.1 installations on Windows using the H2 database. This is intended as a development environment.

With a little more work you could install ThingWorx 9.1 for another DB:
- change the `platform-settings.json` file
- run the DB scripts included as part of the ThingWorx installation package

This artifact neither includes a ThingWorx license (which you have to provide) nor the ThingWorx archive (which you have to download from [support.ptc.com](https://support.ptc.com/appserver/auth/it/esd/product.jsp?prodFamily=TWX))


# How to use this artifact

This artifact allows to install ThingWorx with all related dependencies:
- as a Windows service (you can start and stop from the Windows Services panel)
- as a command prompt window (you can start by running a PowerShell script and stop with Control-C)

First of all you have to update the two scripts (as described below) to fine tune the versions of software dependencies and other minor details:
- `thingworx-provision.ps1`
- `service-install.ps1`
- `service-remove.ps1`

Then change the passwords in the `platform-settings.json` file.

Finally run the `thingworx-provision.ps1` script in a Administrative PowerShell console.

If you plan to install ThingWorx as a Windows service, also run `service-install.ps1` in an Administrative PowerShell console.


# Update the provisioning script

Edit `provision.ps1`:
- Update the Tomcat9 version to the [latest version](https://tomcat.apache.org/download-90.cgi)
- Update the OpenSSL version to the [latest version](http://wiki.overbyte.eu/wiki/index.php/ICS_Download#Download_OpenSSL_Binaries_.28required_for_SSL-enabled_components.29)
- Tailor the SSL CONFIGURATION to your environemnt

Stage files in the staging folder
- `Thingworx.war`: bring your own ThingWorx
- License file: bring your own license


# Update the service installer and removal scripts

Edit `service-install.ps1`:
- Update JAVA home variable
- Update Tomcat9 version
- Update Tomcat9 ports, certificate and key files

Edit `service-remove.ps1`:
- Update Tomcat9 version

