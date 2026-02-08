$ErrorActionPreference = "Stop"

# Get download URL
Write-Host "Fetching latest stable release info..."
$json = Invoke-RestMethod -Uri "https://storage.googleapis.com/flutter_infra_release/releases/releases_windows.json"
$stable_hash = $json.current_release.stable
$release = $json.releases | Where-Object { $_.hash -eq $stable_hash }
$archive_url = "https://storage.googleapis.com/flutter_infra_release/releases/" + $release.archive
$version = $release.version

Write-Host "Latest stable version: $version"
Write-Host "Download URL: $archive_url"

$zipPath = "$env:TEMP\flutter_windows.zip"
$installDir = "C:\flutter"

# Download
if (-not (Test-Path $zipPath)) {
    Write-Host "Downloading Flutter SDK..."
    Invoke-WebRequest -Uri $archive_url -OutFile $zipPath
}

# Extract
if (Test-Path $installDir) {
    Write-Host "Removing existing installation..."
    Remove-Item -Path $installDir -Recurse -Force
}

Write-Host "Extracting to C:\ ..."
Expand-Archive -Path $zipPath -DestinationPath "C:\" -Force

# Rename if needed (zip usually contains 'flutter' folder)
if (-not (Test-Path "C:\flutter")) {
    Write-Host "Error: Extraction failed or folder structure unexpected."
    exit 1
}

# Add to PATH
$binPath = "C:\flutter\bin"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$binPath*") {
    Write-Host "Adding $binPath to User PATH..."
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$binPath", "User")
}

Write-Host "Installation complete."
Write-Host "Please restart your terminal to use 'flutter' command."
