# Sine with optional degree input.

function Get-CalcSin {
    param(
        [double] $Value,
        [switch] $Degrees
    )
    if ($Degrees) {
        $Value = $Value * [Math]::PI / 180.0
    }
    return [Math]::Sin($Value)
}
