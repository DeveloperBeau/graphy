# Key material helpers for the revblocks cipher.

function Get-RevBlocksDefaultKey {
    return "4"
}

function Test-RevBlocksKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-RevBlocksKeyId {
    return "revblocks:4"
}
