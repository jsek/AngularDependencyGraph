@echo off

SET sourceDir=%~dp0..\nw-cache
SET destination=%~dp0..\cache

:: Cleanup

if exist %destination% rd /S /Q %destination% 
if not exist %destination% mkdir %destination%

:: Extract

%~dp07zip\7z.exe x -o%destination% %~dp0nw-0.10.5.7z

:: Hide

attrib +H %destination%
attrib +H %sourceDir%