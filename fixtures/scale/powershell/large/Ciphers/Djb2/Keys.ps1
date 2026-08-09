# Key material helpers for the djb2 cipher.

function Get-Djb2DefaultKey {
    return "5381"
}

function Test-Djb2Key {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-Djb2KeyId {
    return "djb2:5381"
}
