# Key material helpers for the xordigest cipher.

function Get-XorDigestDefaultKey {
    return "0"
}

function Test-XorDigestKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-XorDigestKeyId {
    return "xordigest:0"
}
