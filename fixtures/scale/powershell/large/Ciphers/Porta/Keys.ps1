# Key material helpers for the porta cipher.

function Get-PortaDefaultKey {
    return "GLACIER"
}

function Test-PortaKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key.Length -ge 3
}

function Get-PortaKeyId {
    return "porta:GLACIER"
}
