# Hyperbolic sine.

function Get-CalcSinh {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Sinh($Value)
}
