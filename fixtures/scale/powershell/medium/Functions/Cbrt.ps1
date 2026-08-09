# Cube root.

function Get-CalcCbrt {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Cbrt($Value)
}
