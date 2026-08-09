# Key material helpers for the crclite cipher.

function Get-CrcLiteDefaultKey {
    return "4294967295"
}

function Test-CrcLiteKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-CrcLiteKeyId {
    return "crclite:4294967295"
}
