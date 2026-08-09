# Inverse cosine.

function Get-CalcAcos {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Acos($Value)
}
