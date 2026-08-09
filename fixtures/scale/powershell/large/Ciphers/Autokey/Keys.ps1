# Key material helpers for the autokey cipher.

function Get-AutokeyDefaultKey {
    return "QUEEN"
}

function Test-AutokeyKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key.Length -ge 3
}

function Get-AutokeyKeyId {
    return "autokey:QUEEN"
}
