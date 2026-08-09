# Third power.

function Get-CalcCube {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return $Value * $Value * $Value
}
