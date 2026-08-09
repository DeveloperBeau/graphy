# Key material helpers for the xorshift cipher.

function Get-XorShiftDefaultKey {
    return "911"
}

function Test-XorShiftKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-XorShiftKeyId {
    return "xorshift:911"
}
