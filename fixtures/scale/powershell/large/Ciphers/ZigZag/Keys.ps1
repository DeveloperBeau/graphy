# Key material helpers for the zigzag cipher.

function Get-ZigZagDefaultKey {
    return "2"
}

function Test-ZigZagKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-ZigZagKeyId {
    return "zigzag:2"
}
