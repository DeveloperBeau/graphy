# Round toward negative infinity.

function Get-CalcFloor {
    [CmdletBinding()]
    param([double] $Value)
    if ([double]::IsNaN($Value)) {
        return [double]::NaN
    }
    return [Math]::Floor($Value)
}
