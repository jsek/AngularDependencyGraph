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

: start application
%~dp0\..\buildTools\7zip\7z.exe a %Zip% %~dp0*
%~dp0\..\buildTools\node-webkit\nw %Zip%

: cleanup
: del %Zip%
exit