# Key material helpers for the rc4lite cipher.

function Get-Rc4LiteDefaultKey {
    return "17"
}

function Test-Rc4LiteKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-Rc4LiteKeyId {
    return "rc4lite:17"
}
