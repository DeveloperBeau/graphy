# Key material helpers for the ctrxor cipher.

function Get-CtrXorDefaultKey {
    return "7"
}

function Test-CtrXorKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-CtrXorKeyId {
    return "ctrxor:7"
}
