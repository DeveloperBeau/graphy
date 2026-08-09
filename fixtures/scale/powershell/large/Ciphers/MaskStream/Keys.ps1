# Key material helpers for the maskstream cipher.

function Get-MaskStreamDefaultKey {
    return "90"
}

function Test-MaskStreamKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-MaskStreamKeyId {
    return "maskstream:90"
}
