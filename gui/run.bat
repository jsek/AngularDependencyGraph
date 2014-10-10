@echo off
: run minimized
if not defined PIL (
    set PIL=1
    start /min "" %~0
    exit /b
)

SET Zip=%~dp0AngularGraphGenerator.zip

: cleanup oldfiles
if exist %Zip% del %Zip%

SET modules=%~dp0node_modules
if not exist %modules%          mkdir %modules%
if not exist %modules%\node-fs  xcopy /e /i %~dp0..\node_modules\node-fs  %modules%\node-fs
if not exist %modules%\jade     xcopy /e /i %~dp0..\node_modules\jade     %modules%\jade

: start application
%~dp0\..\buildTools\7zip\7z.exe a %Zip% %~dp0*
%~dp0\..\buildTools\node-webkit\nw %Zip%

: cleanup
: del %Zip%
exit