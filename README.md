# What is this about?

I created this PowerShell-based artifact to simplify ThingWorx 9.1 installations on Windows.
The resulting ThingWorx installation is intended as a development environment.

This artifact neither includes a ThingWorx license (which you have to provide after retrieving the License ID) nor the ThingWorx archive (which you have to download from [support.ptc.com](https://support.ptc.com/appserver/auth/it/esd/product.jsp?prodFamily=TWX)). It also does not include the DB scripts available as part of the ThingWorx installation.


# How to use this artifact

With this artifact you can install ThingWorx and all related dependencies.
You can then run it as a:
- Command Prompt application (start by running a batch file and stop it with Control-C)
- Windows service (start and stop from the Windows Services panel)

First of all you have to tailor the scripts described below (details in the next sections):
- `thingworx-provision.ps1`
- `service-install.ps1`

The above scripts include a section with the variables to tailor.

Then you have to change the default passwords in `thingworx\platform-settings.json`.



# Tailor the provisioning script

Edit `thingworx-provision.ps1`:
- Update the Tomcat9 version to the [latest version](https://tomcat.apache.org/download-90.cgi)
- Update the OpenSSL version to the [latest version](http://wiki.overbyte.eu/wiki/index.php/ICS_Download#Download_OpenSSL_Binaries_.28required_for_SSL-enabled_components.29)
- Tailor the SSL CONFIGURATION to your environemnt by setting the host name, a 2-letter country code, the name of your organization and the certificate validity in days.

Stage the following files and folders in the `staging` folder:
- `Thingworx.war` file: bring your own ThingWorx
- `install` folder: the DB scripts part of ThingWorx installation


# Tailor the service install and remove scripts

Edit `service-install.ps1` and update the Apache Tomcat ports in the TAILORING section.


# Run the provisioning script

Open an Administrative PowerShell console and run `.\thingworx-provision.ps1`.


# Tailor and run the PostgreSQL DB script

Tailor the DB script `thingworx\install\pg-install.bat`.
Then, before running the script, make sure that the DB client is in the PATH (for PostgreSQL this is the PostgreSQL `bin` folder).
Run the script in a Command Prompt window, or just double-click on it in the Windows Explorer.


# Start ThingWorx

Start ThingWorx without a license by running the `console-start-thingworx.bat` batch file generated as part of the provisioning script.

Get the license ID from the generated file `thingworx\licenseRequestFile.txt` or from `Application.log`, request a license from [PTC License Support](https://support.ptc.com/apps/licensePortal/auth/ssl/index), rename it to `license_capability_response.bin` and copy the file to the `thingworx` folder.


# Install ThingWorx as a Windows service

Run `.\service-install.ps1` if you intend to install ThingWorx as a Windows service.

