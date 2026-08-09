# Key material helpers for the sdbm cipher.

function Get-SdbmDefaultKey {
    return "0"
}

function Test-SdbmKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-SdbmKeyId {
    return "sdbm:0"
}
