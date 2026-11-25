@echo off
setlocal
set "QUESTA_EXE="
for %%V in (vsim.exe) do set "QUESTA_EXE=%%~$PATH:V"
if not defined QUESTA_EXE for /d %%D in ("C:\altera_lite\*") do if exist "%%D\questa_fse\win64\vsim.exe" set "QUESTA_EXE=%%D\questa_fse\win64\vsim.exe"
if not defined QUESTA_EXE (
    echo No se encontro Questa. Agrega vsim.exe a PATH.
    exit /b 1
)
"%QUESTA_EXE%" -do "source {%~dp0simular_questa.tcl}"
endlocal
