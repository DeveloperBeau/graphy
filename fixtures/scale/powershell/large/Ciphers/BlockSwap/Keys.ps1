# Key material helpers for the blockswap cipher.

function Get-BlockSwapDefaultKey {
    return "8"
}

function Test-BlockSwapKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-BlockSwapKeyId {
    return "blockswap:8"
}
