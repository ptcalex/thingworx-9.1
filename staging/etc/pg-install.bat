@echo off

REM ### CONFIGURATION SECTION ###

set host=localhost
set port=5432
set db=thingworx
set ts=%db%
set loc=C:\var\lib\PostgreSQL\%db%
set pg=postgres
set tw=twadmin



REM ### NO NEED TO CHANGE BELOW ###

set script=thingworxPostgres
set sch=public
set options=all



cls

:DB
if not exist %loc% mkdir %loc%
call %script%DBSetup.bat -H %host% -P %port% -D %db% -T %ts% -L %loc% -A %pg% -U %tw%

:SCHEMA
call %script%SchemaSetup.bat -H %host% -P %port% -D %db% -S %sch% -U %tw% -O %options%

:END
echo End.
