# Key material helpers for the quagmire cipher.

function Get-QuagmireDefaultKey {
    return "OCEAN"
}

function Test-QuagmireKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key.Length -ge 3
}

function Get-QuagmireKeyId {
    return "quagmire:OCEAN"
}
