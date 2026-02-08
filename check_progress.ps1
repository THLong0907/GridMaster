$url = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.38.9-stable.zip"
try {
    $req = [System.Net.WebRequest]::Create($url)
    $req.Method = "HEAD"
    $resp = $req.GetResponse()
    $total = $resp.ContentLength
    $resp.Close()
}
catch {
    Write-Host "Error getting header: $_"
    exit
}

$tempFile = "$env:TEMP\flutter_windows.zip"
if (Test-Path $tempFile) {
    $current = (Get-Item $tempFile).Length
    if ($total -gt 0) {
        $percent = [math]::Round(($current / $total) * 100, 2)
        Write-Host "Total: $total"
        Write-Host "Current: $current"
        Write-Host "Percent: $percent %"
    }
    else {
        Write-Host "Total size unknown."
        Write-Host "Current: $current"
    }
}
else {
    Write-Host "File not found."
}
