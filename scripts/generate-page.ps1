<#
.SYNOPSIS
    Generates or updates the Data Engine landing page using Fabro with a per-run requirement.
.DESCRIPTION
    Runs the 'web-page' Fabro workflow for sw-engineer-tarikul/AI-Explore without needing
    to edit or commit web/BRIEF.md. You can provide the requirement as an argument or interactively.
.EXAMPLE
    .\scripts\generate-page.ps1
.EXAMPLE
    .\scripts\generate-page.ps1 -Requirement "Data Engine landing page: highlight instant type coercion and clean minimal design"
.EXAMPLE
    .\scripts\generate-page.ps1 -Requirement "Add dark mode toggle and interactive formula playground" -Detach
#>
[CmdletBinding()]
param(
    [Parameter(Position=0, Mandatory=$false)]
    [string]$Requirement,

    [switch]$Detach,

    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# If no requirement is provided via CLI argument, prompt the user
if (-not $Requirement -or $Requirement.Trim() -eq "") {
    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "         Data Engine Landing Page Automation" -ForegroundColor Cyan
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "Enter your requirement for the landing page below."
    Write-Host "(Press Enter to use default: Data Engine clean minimal landing page)" -ForegroundColor DarkGray
    Write-Host ""
    $inputReq = Read-Host "Requirement"
    if ($inputReq -and $inputReq.Trim() -ne "") {
        $Requirement = $inputReq.Trim()
    } else {
        $Requirement = "Data Engine landing page: highlight instant type coercion, field validation, and clean minimal design"
    }
}

Write-Host ""
Write-Host "[1/2] Preparing Fabro run..." -ForegroundColor Green
Write-Host "  Repository:  sw-engineer-tarikul/AI-Explore@main"
Write-Host "  Workflow:    web-page"
Write-Host "  Requirement: $Requirement"

$dockerArgs = @(
    "exec",
    "-i",
    "fabro-server",
    "fabro",
    "run"
)

if ($DryRun) {
    $dockerArgs += "--dry-run"
}

if ($Detach) {
    $dockerArgs += "-d"
}

$dockerArgs += @(
    "--target", "sw-engineer-tarikul/AI-Explore@main",
    "--goal", $Requirement,
    "sw-engineer-tarikul/AI-Explore@main:web-page"
)

Write-Host "[2/2] Executing workflow on Fabro server..." -ForegroundColor Green
& docker @dockerArgs
