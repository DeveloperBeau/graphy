# Base-2 logarithm.

function Get-CalcLog2 {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Log2($Value)
}
