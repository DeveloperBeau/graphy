# Key material helpers for the keymix cipher.

function Get-KeymixDefaultKey {
    return "ZEBRA"
}

function Test-KeymixKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key.Length -ge 3
}

function Get-KeymixKeyId {
    return "keymix:ZEBRA"
}
