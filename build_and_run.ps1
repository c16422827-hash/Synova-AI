# Build and run script for Windows (PowerShell)
# - Creates a venv in .venv
# - Installs requirements
# - Starts backend (uvicorn) and a static file server for frontend
# - Captures screenshots with Playwright
# - Builds a PDF with screenshots
# Usage: ./build_and_run.ps1

$ErrorActionPreference = 'Stop'
$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location $root

if (-Not (Test-Path -Path .venv)) {
    python -m venv .venv
}
$venvPython = Join-Path $root '.venv\Scripts\python.exe'
$venvPip = Join-Path $root '.venv\Scripts\pip.exe'

Write-Host "Using python: $venvPython"

# Upgrade pip and install requirements
& $venvPip install -U pip
& $venvPip install -r requirements.txt

# Install playwright browsers if playwright installed
try {
    & $venvPython -m playwright install
}
catch {
    Write-Host "playwright browsers install failed or playwright not installed: $_"
}

# start backend
$backendLog = Join-Path $root 'backend.log'
$frontendLog = Join-Path $root 'frontend.log'

Write-Host "Starting backend..."
$backendCmd = "$venvPython -m uvicorn main:app --host 127.0.0.1 --port 8000 --reload"
Start-Process -FilePath $venvPython -ArgumentList '-m', 'uvicorn', 'main:app', '--host', '127.0.0.1', '--port', '8000' -NoNewWindow -RedirectStandardOutput $backendLog -RedirectStandardError $backendLog -PassThru
Start-Sleep -Seconds 1

# serve frontend via simple http.server from the project root on port 8080
Write-Host "Starting frontend static server on port 8080..."
Start-Process -FilePath $venvPython -ArgumentList '-m', 'http.server', '8080' -NoNewWindow -RedirectStandardOutput $frontendLog -RedirectStandardError $frontendLog -PassThru
Start-Sleep -Seconds 1

# capture screenshots
Write-Host "Capturing screenshots..."
& $venvPython capture_screenshots.py --url http://127.0.0.1:8080/terrestrial.html --out screenshots | Tee-Object -Variable scr

# build pdf
Write-Host "Building PDF with screenshots..."
$screens = $scr -join ' '
& $venvPython mkpdf_with_screenshots.py $screens

Write-Host "Done. Opening PDF..."
Start-Process -FilePath (Join-Path $root 'HOWTO_with_screenshots.pdf')

Write-Host "Logs: $backendLog, $frontendLog"


