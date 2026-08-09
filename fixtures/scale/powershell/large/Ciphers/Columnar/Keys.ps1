# Key material helpers for the columnar cipher.

function Get-ColumnarDefaultKey {
    return "4"
}

function Test-ColumnarKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-ColumnarKeyId {
    return "columnar:4"
}
