# Key material helpers for the xorbasic cipher.

function Get-XorBasicDefaultKey {
    return "90"
}

function Test-XorBasicKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-XorBasicKeyId {
    return "xorbasic:90"
}
