$ErrorActionPreference = "Stop"

# Cleanup old temp file
$zipPath = "$env:TEMP\flutter_windows.zip"
if (Test-Path $zipPath) {
    Write-Host "Removing partial download..."
    Remove-Item -Path $zipPath -Force
}

# Get download URL again just in case
$json = Invoke-RestMethod -Uri "https://storage.googleapis.com/flutter_infra_release/releases/releases_windows.json"
$stable_hash = $json.current_release.stable
$release = $json.releases | Where-Object { $_.hash -eq $stable_hash }
$archive_url = "https://storage.googleapis.com/flutter_infra_release/releases/" + $release.archive
$version = $release.version

Write-Host "Downloading Flutter version: $version"
Write-Host "URL: $archive_url"

# BITS Download
Write-Host "Starting BITS transfer..."
Start-BitsTransfer -Source $archive_url -Destination $zipPath -Priority High

# Verify download size
if ((Get-Item $zipPath).Length -lt 100000000) {
    Write-Host "Error: Downloaded file seems too small."
    exit 1
}

# Install
$installDir = "C:\flutter"
if (Test-Path $installDir) {
    Write-Host "Cleaning install directory..."
    Remove-Item -Path $installDir -Recurse -Force
}

Write-Host "Extracting..."
Expand-Archive -Path $zipPath -DestinationPath "C:\" -Force

# PATH setup
$binPath = "C:\flutter\bin"
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$binPath", [System.EnvironmentVariableTarget]::User)
$env:Path += ";$binPath"

Write-Host "Installation complete!"
flutter --version
