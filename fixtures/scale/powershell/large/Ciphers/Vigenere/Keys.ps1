# Key material helpers for the vigenere cipher.

function Get-VigenereDefaultKey {
    return "LEMON"
}

function Test-VigenereKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key.Length -ge 3
}

function Get-VigenereKeyId {
    return "vigenere:LEMON"
}
