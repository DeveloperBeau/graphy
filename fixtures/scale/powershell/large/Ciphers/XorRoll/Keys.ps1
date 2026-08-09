# Key material helpers for the xorroll cipher.

function Get-XorRollDefaultKey {
    return "193"
}

function Test-XorRollKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-XorRollKeyId {
    return "xorroll:193"
}
