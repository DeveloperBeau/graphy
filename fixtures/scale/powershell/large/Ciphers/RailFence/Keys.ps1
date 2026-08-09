# Key material helpers for the railfence cipher.

function Get-RailFenceDefaultKey {
    return "6"
}

function Test-RailFenceKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-RailFenceKeyId {
    return "railfence:6"
}
