# graphy installer for Windows (PowerShell).
#
# Downloads the latest release for this machine, extracts it under
# %USERPROFILE%\.graphy, and adds %USERPROFILE%\.graphy\bin to the user PATH.
#
# Usage:
#   irm https://raw.githubusercontent.com/DeveloperBeau/graphy/main/install.ps1 | iex
#   # or pin a version:
#   $env:GRAPHY_VERSION="0.1.0"; irm .../install.ps1 | iex
$ErrorActionPreference = "Stop"

$Repo        = if ($env:GRAPHY_REPO) { $env:GRAPHY_REPO } else { "https://github.com/DeveloperBeau/graphy" }
$Version     = if ($env:GRAPHY_VERSION) { $env:GRAPHY_VERSION } else { "latest" }
$InstallRoot = if ($env:GRAPHY_HOME) { $env:GRAPHY_HOME } else { Join-Path $env:USERPROFILE ".graphy" }

switch ($env:PROCESSOR_ARCHITECTURE) {
  "AMD64" { $Arch = "x86_64" }
  default { throw "unsupported architecture: $($env:PROCESSOR_ARCHITECTURE) (only x86_64 Windows builds are published)" }
}

if ($Version -eq "latest") {
  # Use the API endpoint (follows redirects cleanly on Windows PowerShell 5.1,
  # unlike capturing the 302 from /releases/latest).
  $api = $Repo -replace "^https://github.com/", "https://api.github.com/repos/"
  Write-Host "graphy install: resolving latest version from $api/releases/latest"
  $tag = (Invoke-RestMethod -Uri "$api/releases/latest" -Headers @{ "User-Agent" = "graphy-install" }).tag_name
  if (-not $tag) { throw "could not resolve latest version" }
  $Version = $tag.TrimStart("v")
}

$Archive = "graphy-$Version-$Arch-windows.zip"
$Url     = "$Repo/releases/download/v$Version/$Archive"
$Tmp     = Join-Path $env:TEMP "graphy-install-$Version"
New-Item -ItemType Directory -Force -Path $Tmp | Out-Null
$ZipPath = Join-Path $Tmp $Archive

Write-Host "graphy install: downloading $Url"
Invoke-WebRequest -Uri $Url -OutFile $ZipPath

try {
  Invoke-WebRequest -Uri "$Url.sha256" -OutFile "$ZipPath.sha256"
  $expected = ((Get-Content "$ZipPath.sha256") -split "\s+")[0]
  $actual   = (Get-FileHash $ZipPath -Algorithm SHA256).Hash.ToLower()
  if ($expected -ne $actual) { throw "sha256 mismatch: expected $expected, got $actual" }
  Write-Host "graphy install: sha256 verified"
} catch [System.Net.WebException] {
  Write-Host "graphy install: no sha256 published; skipping verification"
}

New-Item -ItemType Directory -Force -Path (Join-Path $InstallRoot "bin"), (Join-Path $InstallRoot "plugins") | Out-Null
Write-Host "graphy install: extracting to $InstallRoot"
Expand-Archive -Path $ZipPath -DestinationPath $InstallRoot -Force

# Move the binary into bin\ if the archive shipped it at the root.
$rootExe = Join-Path $InstallRoot "graphy.exe"
if (Test-Path $rootExe) {
  Move-Item -Force $rootExe (Join-Path $InstallRoot "bin\graphy.exe")
}

# Add bin to the user PATH (idempotent).
$binDir = Join-Path $InstallRoot "bin"
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$binDir*") {
  [Environment]::SetEnvironmentVariable("Path", "$binDir;$userPath", "User")
  Write-Host "graphy install: added $binDir to your user PATH (restart the shell to pick it up)"
}

Remove-Item -Recurse -Force $Tmp
Write-Host ""
Write-Host "graphy $Version installed."
Write-Host "  binary:  $binDir\graphy.exe"
Write-Host "  plugins: $InstallRoot\plugins"
Write-Host ""
Write-Host "Run: $binDir\graphy.exe doctor"
Write-Host "     $binDir\graphy.exe plugins list"
