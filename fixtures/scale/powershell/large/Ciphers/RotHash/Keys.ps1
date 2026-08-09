# Key material helpers for the rothash cipher.

function Get-RotHashDefaultKey {
    return "99991"
}

function Test-RotHashKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-RotHashKeyId {
    return "rothash:99991"
}
