# Key material helpers for the feistel cipher.

function Get-FeistelDefaultKey {
    return "101"
}

function Test-FeistelKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-FeistelKeyId {
    return "feistel:101"
}
