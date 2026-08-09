# Key material helpers for the rotmix cipher.

function Get-RotmixDefaultKey {
    return "3"
}

function Test-RotmixKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-RotmixKeyId {
    return "rotmix:3"
}
