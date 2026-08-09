# Radians to degrees.

function Get-CalcRad2Deg {
    [CmdletBinding()]
    param([double] $Radians)
    if ([double]::IsNaN($Radians)) {
        return [double]::NaN
    }
    return $Radians * 180.0 / [Math]::PI
}
