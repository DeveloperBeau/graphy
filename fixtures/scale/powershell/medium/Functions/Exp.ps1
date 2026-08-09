# Natural exponent.

function Get-CalcExp {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Exp($Value)
}
