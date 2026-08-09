# Key material helpers for the fnv1a cipher.

function Get-Fnv1aDefaultKey {
    return "2166136261"
}

function Test-Fnv1aKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-Fnv1aKeyId {
    return "fnv1a:2166136261"
}
