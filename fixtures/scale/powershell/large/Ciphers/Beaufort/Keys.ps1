# Key material helpers for the beaufort cipher.

function Get-BeaufortDefaultKey {
    return "FORTRESS"
}

function Test-BeaufortKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key.Length -ge 3
}

function Get-BeaufortKeyId {
    return "beaufort:FORTRESS"
}
