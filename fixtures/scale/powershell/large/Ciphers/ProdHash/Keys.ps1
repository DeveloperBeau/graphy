# Key material helpers for the prodhash cipher.

function Get-ProdHashDefaultKey {
    return "7"
}

function Test-ProdHashKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-ProdHashKeyId {
    return "prodhash:7"
}
