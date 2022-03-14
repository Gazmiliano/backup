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

@echo off

rem ============================================================
rem   Глобальные переменные
rem ============================================================

set backupHost=
set backupHostPort=
set backupHostUser=
set backupHostPass=
set localPath=

rem ============================================================
rem   Берем дату (сегодня)
rem ============================================================

for /f "tokens=2 delims==" %%G in ('wmic os get localdatetime /value') do set datetime=%%G
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set dt=%year%-%month%-%day%
set localPath=%localPath%\%dt%

rem ============================================================
rem   Подготавливаем локалные папки
rem ============================================================

mkdir %dt%
mkdir %localPath%\var
mkdir %localPath%\var\www

rem ============================================================
rem   Копируем файлы/папки с линукс сервера на локальный каталог
rem ============================================================

"C:\Program Files\PuTTY\pscp" -r -P %backupHostPort% -pw %backupHostPass% %backupHostUser%@%backupHost%:/var/www %localPath%/var/www
