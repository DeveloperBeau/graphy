# Key material helpers for the addmod cipher.

function Get-AddmodDefaultKey {
    return "17"
}

function Test-AddmodKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-AddmodKeyId {
    return "addmod:17"
}
