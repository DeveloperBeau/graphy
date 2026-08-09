# Key material helpers for the atbash cipher.

function Get-AtbashDefaultKey {
    return "3"
}

function Test-AtbashKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-AtbashKeyId {
    return "atbash:3"
}
