# Hyperbolic cosine.

function Get-CalcCosh {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Cosh($Value)
}
