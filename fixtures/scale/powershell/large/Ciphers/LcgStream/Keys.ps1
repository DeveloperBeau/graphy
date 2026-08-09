# Key material helpers for the lcgstream cipher.

function Get-LcgStreamDefaultKey {
    return "42"
}

function Test-LcgStreamKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-LcgStreamKeyId {
    return "lcgstream:42"
}
