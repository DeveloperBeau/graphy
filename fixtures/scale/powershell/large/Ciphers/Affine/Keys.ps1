# Key material helpers for the affine cipher.

function Get-AffineDefaultKey {
    return "8"
}

function Test-AffineKey {
    param([string] $Key)
    if ([string]::IsNullOrEmpty($Key)) {
        return $false
    }
    return $Key -match "^[0-9]+$"
}

function Get-AffineKeyId {
    return "affine:8"
}
