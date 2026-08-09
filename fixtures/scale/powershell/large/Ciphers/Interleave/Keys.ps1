# Key material helpers for the interleave cipher.

function Get-InterleaveDefaultKey {
    return "8"
}

function Test-InterleaveKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-InterleaveKeyId {
    return "interleave:8"
}
