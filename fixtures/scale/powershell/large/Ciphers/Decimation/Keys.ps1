# Key material helpers for the decimation cipher.

function Get-DecimationDefaultKey {
    return "0"
}

function Test-DecimationKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-DecimationKeyId {
    return "decimation:0"
}
