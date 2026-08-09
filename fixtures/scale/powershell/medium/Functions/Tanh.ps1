# Hyperbolic tangent.

function Get-CalcTanh {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Tanh($Value)
}
