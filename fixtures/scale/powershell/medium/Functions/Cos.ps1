# Cosine with optional degree input.

function Get-CalcCos {
    param(
        [double] $Value,
        [switch] $Degrees
    )
    if ($Degrees) {
        $Value = $Value * [Math]::PI / 180.0
    }
    return [Math]::Cos($Value)
}
