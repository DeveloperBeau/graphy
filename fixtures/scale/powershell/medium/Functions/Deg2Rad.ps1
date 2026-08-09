# Degrees to radians.

function Get-CalcDeg2Rad {
    [CmdletBinding()]
    param([double] $Degrees)
    if ([double]::IsNaN($Degrees)) {
        return [double]::NaN
    }
    return $Degrees * [Math]::PI / 180.0
}
