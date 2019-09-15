@ECHO OFF

IF NOT EXIST out MKDIR out

XCOPY src\*.lua out /f /i /s /y

PUSHD src
SETLOCAL DISABLEDELAYEDEXPANSION

FOR /f "delims=" %%A IN ('forfiles /s /m *.moon /c "cmd /c ECHO @RELPATH"') DO (
  SET "file=%%~A"
  SETLOCAL ENABLEDELAYEDEXPANSION
  cmd /c moonc -t ../out !file:~2!
  ENDLOCAL
)

ENDLOCAL
POPD
