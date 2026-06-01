# graphy uninstaller for Windows (PowerShell).
#
# Removes what install.ps1 created: the .graphy tree (binary + plugins) and the
# bin\ entry from your user PATH.
#
# Usage:
#   irm https://raw.githubusercontent.com/DeveloperBeau/graphy/main/uninstall.ps1 | iex
$ErrorActionPreference = "Stop"

$InstallRoot = if ($env:GRAPHY_HOME) { $env:GRAPHY_HOME } else { Join-Path $env:USERPROFILE ".graphy" }
$binDir = Join-Path $InstallRoot "bin"

if (Test-Path $InstallRoot) {
  Write-Host "graphy uninstall: removing $InstallRoot"
  Remove-Item -Recurse -Force $InstallRoot
} else {
  Write-Host "graphy uninstall: $InstallRoot not found (nothing to remove)"
}

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -like "*$binDir*") {
  $newPath = (($userPath -split ";") | Where-Object { $_ -and $_ -ne $binDir }) -join ";"
  [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
  Write-Host "graphy uninstall: removed $binDir from your user PATH"
}

Write-Host ""
Write-Host "graphy uninstalled. Restart your shell to drop it from PATH."
Write-Host ""
Write-Host "Not removed (do these yourself if you want):"
Write-Host "  - cargo installs:     cargo uninstall graphy-cli"
Write-Host "  - Claude Code plugin: /plugin uninstall graphy@graphy"
