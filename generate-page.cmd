@echo off
setlocal

rem Launch PowerShell with ExecutionPolicy Bypass to support multi-line input and automatic PR creation
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\generate-page.ps1" %*

if errorlevel 1 (
    echo.
    echo Workflow exited with an error.
)

echo.
pause
