# Key material helpers for the rotblocks cipher.

function Get-RotBlocksDefaultKey {
    return "6"
}

function Test-RotBlocksKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-RotBlocksKeyId {
    return "rotblocks:6"
}
