# Key material helpers for the rot13 cipher.

function Get-Rot13DefaultKey {
    return "13"
}

function Test-Rot13Key {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-Rot13KeyId {
    return "rot13:13"
}
