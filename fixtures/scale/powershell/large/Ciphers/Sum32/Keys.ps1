# Key material helpers for the sum32 cipher.

function Get-Sum32DefaultKey {
    return "0"
}

function Test-Sum32Key {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-Sum32KeyId {
    return "sum32:0"
}
