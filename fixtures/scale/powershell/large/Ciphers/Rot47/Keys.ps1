# Key material helpers for the rot47 cipher.

function Get-Rot47DefaultKey {
    return "47"
}

function Test-Rot47Key {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-Rot47KeyId {
    return "rot47:47"
}
