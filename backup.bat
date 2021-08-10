@echo off

rem =====================================================
rem GLOBALS
rem =====================================================

set backupHost=agrogold.kz
set backupHostPort=49521
set backupHostUser=root
set backupHostPass=blacksheepwall~~
set localPath=C:\Users\gggnu\Desktop\projects\backup\Agrogold

rem =====================================================
rem Date is backup dir
rem =====================================================

for /f "tokens=2 delims==" %%G in ('wmic os get localdatetime /value') do set datetime=%%G
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set dt=%year%-%month%-%day%
set localPath=%localPath%\%dt%

rem =====================================================
rem Create dir
rem =====================================================

mkdir %dt%
mkdir %localPath%\etc
mkdir %localPath%\usr
mkdir %localPath%\usr\share
mkdir %localPath%\usr\share\nginx

rem =====================================================
rem Backup Script
rem =====================================================

"C:\Program Files\PuTTY\plink" -P %backupHostPort% -batch -pw %backupHostPass% %backupHostUser%@%backupHost% /root/backup/remoteBackupDatabase.sh
"C:\Program Files\PuTTY\pscp" -P %backupHostPort% -pw %backupHostPass% %backupHostUser%@%backupHost%:/root/backup/database.sql.gz %localPath%
"C:\Program Files\PuTTY\plink" -P %backupHostPort% -batch -pw %backupHostPass% %backupHostUser%@%backupHost% rm -f /root/backup/database.sql.gz

"C:\Program Files\PuTTY\pscp" -r -P %backupHostPort% -pw %backupHostPass% %backupHostUser%@%backupHost%:/etc %localPath%/etc
"C:\Program Files\PuTTY\pscp" -r -P %backupHostPort% -pw %backupHostPass% %backupHostUser%@%backupHost%:/usr/share/nginx %localPath%/usr/share/nginx

