# Key material helpers for the scytale cipher.

function Get-ScytaleDefaultKey {
    return "6"
}

function Test-ScytaleKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-ScytaleKeyId {
    return "scytale:6"
}
