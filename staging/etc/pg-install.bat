@echo off

REM ### TAILORING SECTION ###

set host=localhost
set port=5432
set db=thingworx
set ts=%db%
set loc=C:\var\lib\PostgreSQL\%db%
set pg=postgres
set tw=twadmin



REM ### NO NEED TO CHANGE BELOW THIS LINE ###

set script=thingworxPostgres
set sch=public
set options=all



cls
if not exist %loc% mkdir %loc%
pushd %~dp0

:DB
call %script%DBSetup.bat -H %host% -P %port% -D %db% -T %ts% -L %loc% -A %pg% -U %tw%

:SCHEMA
call %~dp0%script%SchemaSetup.bat -H %host% -P %port% -D %db% -S %sch% -U %tw% -O %options%

:END
popd
