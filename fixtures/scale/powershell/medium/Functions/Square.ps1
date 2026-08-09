# Second power.

function Get-CalcSquare {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return $Value * $Value
}
