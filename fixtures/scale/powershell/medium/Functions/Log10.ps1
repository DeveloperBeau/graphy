# Base-10 logarithm.

function Get-CalcLog10 {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Log10($Value)
}
