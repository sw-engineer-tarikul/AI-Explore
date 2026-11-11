@echo off
setlocal enabledelayedexpansion

echo ==========================================================
echo          Data Engine Landing Page Automation
echo ==========================================================
echo.
set "REQ="
set /p REQ="Enter requirement (or press Enter for default): "

if "!REQ!"=="" (
    set "REQ=Data Engine landing page: highlight instant type coercion, field validation, and clean minimal design"
)

echo.
echo Launching Fabro workflow with requirement:
echo "!REQ!"
echo.

docker exec -i fabro-server fabro run --target sw-engineer-tarikul/AI-Explore@main --goal "!REQ!" sw-engineer-tarikul/AI-Explore@main:web-page

echo.
pause
