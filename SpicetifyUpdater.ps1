# Detect the user's username dynamically
$spotifyPath = "C:\Users\$env:USERNAME\AppData\Roaming\Spotify"
$storeSpotifyPath = "C:\Users\$env:USERNAME\AppData\Local\Packages\SpotifyAB.SpotifyMusic_*"

$spotifyExe = Join-Path $spotifyPath "Spotify.exe"
$storeSpotifyExe = Join-Path $storeSpotifyPath "LocalCache\Spotify\Spotify.exe"
$updatePath = Join-Path $spotifyPath "Update"

# Check to see if user is using Microsoft Store version
if (Test-Path $storeSpotifyExe) {
    Write-Host "Windows: There is great chance that you are using Microsoft Store Spotify." -ForegroundColor Yellow
    Write-Host "Please double check that in Spotify About page."
    Write-Host "If you are actually using Microsoft Store Spotify, remove it completely."
    Write-Host "Go to the Spotify website to download normal version installer." -ForegroundColor Yellow
    exit
}

# Check if Spotify.exe exists in the path it's meant to be in
if (-not (Test-Path $spotifyExe)) {
    Write-Host "Spotify.exe not found at $spotifyExe" -ForegroundColor Red
    exit
}

# Initialize last modified time
$lastModified = (Get-Item $spotifyExe).LastWriteTime

# Monitor for Spotify updates
while ($true) {
    # Check for modifications in the Update folder that Spotify has
    if ((Test-Path $updatePath) -and ((Get-ChildItem $updatePath | Measure-Object).Count -gt 0)) {
        Write-Host "Spotify update detected in Update folder. Applying Spicetify..." -ForegroundColor Green

        # Run Spicetify
        spicetify backup apply
        Start-Sleep -Seconds 10
        
        # Restart Spotify after Spicetify apply
        Write-Host "Restarting Spotify..." -ForegroundColor Green
        Stop-Process -Name "Spotify" -Force
        Start-Process $spotifyExe
        Start-Sleep -Seconds 5
    }

    # Check for modifications to Spotify's exe
    $currentModified = (Get-Item $spotifyExe).LastWriteTime
    if ($currentModified -ne $lastModified) {
        Write-Host "Spotify.exe modification detected. Applying Spicetify..." -ForegroundColor Green

        # Run Spicetify
        spicetify backup apply
        $lastModified = $currentModified
        
        # Restart Spotify after Spicetify apply
        Write-Host "Restarting Spotify..." -ForegroundColor Green
        Stop-Process -Name "Spotify" -Force
        Start-Process $spotifyExe
        Start-Sleep -Seconds 5
    }

    # Delay between checks
    Start-Sleep -Seconds 5
}
