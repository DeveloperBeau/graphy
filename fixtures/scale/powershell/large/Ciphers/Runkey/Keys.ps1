# Key material helpers for the runkey cipher.

function Get-RunkeyDefaultKey {
    return "THEQUICKBROWNFOX"
}

function Test-RunkeyKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key.Length -ge 3
}

function Get-RunkeyKeyId {
    return "runkey:THEQUICKBROWNFOX"
}
