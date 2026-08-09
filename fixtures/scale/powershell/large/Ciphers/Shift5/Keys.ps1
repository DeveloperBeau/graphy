# Key material helpers for the shift5 cipher.

function Get-Shift5DefaultKey {
    return "5"
}

function Test-Shift5Key {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-Shift5KeyId {
    return "shift5:5"
}
