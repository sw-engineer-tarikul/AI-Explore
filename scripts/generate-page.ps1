<#
.SYNOPSIS
    Generates or updates the Data Engine landing page using Fabro with a per-run requirement.
.DESCRIPTION
    Runs the 'web-page' Fabro workflow for sw-engineer-tarikul/AI-Explore without needing
    to edit or commit web/BRIEF.md. You can provide the requirement as an argument or interactively.
.EXAMPLE
    .\scripts\generate-page.ps1
.EXAMPLE
    .\scripts\generate-page.ps1 -Requirement "Add Roadmap section with Schema, Formulas, and Relationships"
.EXAMPLE
    .\generate-page.cmd
#>
[CmdletBinding()]
param(
    [Parameter(Position=0, Mandatory=$false)]
    [string]$Requirement,

    [switch]$Detach,

    [switch]$DryRun
)

$ErrorActionPreference = "Continue"

# If no requirement is provided via CLI argument, prompt interactively
if (-not $Requirement -or $Requirement.Trim() -eq "") {
    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "         Data Engine Landing Page Automation" -ForegroundColor Cyan
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "Enter your requirement below."
    Write-Host "Tip: You can paste multiple lines. Press Enter on an empty line when finished." -ForegroundColor DarkGray
    Write-Host "(Or press Enter immediately to use default landing page requirement)" -ForegroundColor DarkGray
    Write-Host ""

    $lines = [System.Collections.Generic.List[string]]::new()
    while ($true) {
        $line = Read-Host
        if ([string]::IsNullOrWhiteSpace($line)) {
            break
        }
        $lines.Add($line.Trim())
    }

    if ($lines.Count -gt 0) {
        $Requirement = ($lines -join " ").Trim()
    } else {
        $Requirement = "Data Engine landing page: highlight instant type coercion, field validation, and clean minimal design"
    }
}

Write-Host ""
Write-Host "[1/3] Target Configuration" -ForegroundColor Green
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

Write-Host ""
Write-Host "[2/3] Executing workflow on Fabro server..." -ForegroundColor Green

# Execute and stream output
$outputLines = [System.Collections.Generic.List[string]]::new()
& docker @dockerArgs 2>&1 | ForEach-Object {
    if ($_ -is [System.Management.Automation.ErrorRecord]) {
        $line = $_.Exception.Message
    } else {
        $line = "$_"
    }
    if (-not [string]::IsNullOrWhiteSpace($line)) {
        Write-Host $line
        $outputLines.Add($line)
    }
}

$fullOutput = $outputLines -join "`n"

# Check for transient token resolution failure and offer/perform automatic retry
if ($fullOutput -match "token resolution failed") {
    Write-Host ""
    Write-Host "[!] Transient GitHub token refresh timeout detected. Retrying once..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    $outputLines.Clear()
    & docker @dockerArgs 2>&1 | ForEach-Object {
        if ($_ -is [System.Management.Automation.ErrorRecord]) {
            $line = $_.Exception.Message
        } else {
            $line = "$_"
        }
        if (-not [string]::IsNullOrWhiteSpace($line)) {
            Write-Host $line
            $outputLines.Add($line)
        }
    }
    $fullOutput = $outputLines -join "`n"
}

# Find Run ID in output
$runId = $null
if ($fullOutput -match "Run:\s+([01M][0-9A-Z]{25})") {
    $runId = $matches[1]
} elseif ($fullOutput -match "(01M[0-9A-Z]{25})") {
    $runId = $matches[1]
}

Write-Host ""
Write-Host "[3/3] Finalizing Pull Request..." -ForegroundColor Green

if ($runId -and -not $DryRun) {
    # Check if run succeeded
    $inspectJson = docker exec fabro-server fabro inspect --json $runId | ConvertFrom-Json
    $kind = $inspectJson[0].status.kind
    if ($kind -eq "succeeded") {
        Write-Host "Fabro run $runId succeeded! Creating draft Pull Request..." -ForegroundColor Green
        
        $scriptPath = Join-Path $PSScriptRoot "make_pr.py"
        if (Test-Path $scriptPath) {
            py $scriptPath $runId "$Requirement"
        } else {
            Write-Host "Note: scripts/make_pr.py not found locally. PR can be created manually." -ForegroundColor Yellow
        }
    } else {
        Write-Host "Run completed with status: $kind" -ForegroundColor Yellow
    }
} else {
    Write-Host "Completed." -ForegroundColor Green
}
