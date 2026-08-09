# Key material helpers for the adler cipher.

function Get-AdlerDefaultKey {
    return "0"
}

function Test-AdlerKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-AdlerKeyId {
    return "adler:0"
}
