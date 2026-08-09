# Key material helpers for the caesar cipher.

function Get-CaesarDefaultKey {
    return "3"
}

function Test-CaesarKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-CaesarKeyId {
    return "caesar:3"
}
