# Key material helpers for the cbcxor cipher.

function Get-CbcXorDefaultKey {
    return "113"
}

function Test-CbcXorKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-CbcXorKeyId {
    return "cbcxor:113"
}
