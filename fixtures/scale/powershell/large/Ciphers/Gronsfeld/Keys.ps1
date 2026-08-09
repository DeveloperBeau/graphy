# Key material helpers for the gronsfeld cipher.

function Get-GronsfeldDefaultKey {
    return "31415"
}

function Test-GronsfeldKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key.Length -ge 3
}

function Get-GronsfeldKeyId {
    return "gronsfeld:31415"
}
