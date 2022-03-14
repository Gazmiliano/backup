@echo off

rem ============================================================
rem   Это бат скрипт (Windows) для резервного копирования  
rem   папок и файлов с linux машины на текущий компьютер (Windows).
rem   Для работы скрипта нужно: 
rem     - На компьютере Windows был установлен putty
rem     - Достаточно свободного места на компьютере Windows
rem     - Ип адрес linux машины 
rem     - На linux машине доступ по ssh, ssh порт
rem     - Пользователь/Пароль ssh у которого есть доступ
rem         на копирования файлов/папок из linux машины
rem ============================================================

rem ============================================================
rem   Globals
rem ============================================================

set backupHost=192.168.8.103
set backupHostPort=22
set backupHostUser=backup
set backupHostPass=Qwer123~~
set localPath=C:\Users\Gaziz\Desktop\backup

rem ============================================================
rem   Get today date
rem ============================================================

for /f "tokens=2 delims==" %%G in ('wmic os get localdatetime /value') do set datetime=%%G
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set dt=%year%-%month%-%day%
set localPath=%localPath%\%dt%

rem ============================================================
rem   Prepare local dir
rem ============================================================

mkdir %dt%
mkdir %localPath%\var
rem mkdir %localPath%\var\www

rem ============================================================
rem   Remote copy
rem ============================================================

"C:\Program Files\PuTTY\pscp" -r -P %backupHostPort% -pw %backupHostPass% %backupHostUser%@%backupHost%:/var/www %localPath%/var
"C:\Program Files\PuTTY\pscp" -r -P %backupHostPort% -pw %backupHostPass% %backupHostUser%@%backupHost%:/var/www/html/index.nginx-debian.html %localPath%
