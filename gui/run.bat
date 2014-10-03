@echo off
: run minimized
if not defined PIL (
    set PIL=1
    start /min "" %~0
    exit /b
)

: cleanup oldfiles
if exist %~dp0AngularGraphGenerator.zip del %~dp0AngularGraphGenerator.zip

: start application
%~dp0\..\buildTools\7zip\7z.exe a %~dp0AngularGraphGenerator.zip %~dp0*
%~dp0\..\buildTools\node-webkit\nw %~dp0AngularGraphGenerator.zip

: cleanup
del %~dp0AngularGraphGenerator.zip
exit