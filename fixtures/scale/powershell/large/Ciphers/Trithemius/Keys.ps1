# Key material helpers for the trithemius cipher.

function Get-TrithemiusDefaultKey {
    return "ABC"
}

function Test-TrithemiusKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key.Length -ge 3
}

function Get-TrithemiusKeyId {
    return "trithemius:ABC"
}
