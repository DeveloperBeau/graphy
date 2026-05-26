# feature: dot-source, function, call
. .\Helpers.ps1

function Invoke-Service {
    param([string] $Name)
    $greeting = Format-Name -Name $Name
    Write-Host $greeting
    return $greeting
}

function Get-ServiceDescription {
    param([string] $Name)
    return "Service($Name)"
}
