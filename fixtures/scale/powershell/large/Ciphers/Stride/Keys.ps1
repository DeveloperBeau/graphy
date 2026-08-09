# Key material helpers for the stride cipher.

function Get-StrideDefaultKey {
    return "9"
}

function Test-StrideKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-StrideKeyId {
    return "stride:9"
}
