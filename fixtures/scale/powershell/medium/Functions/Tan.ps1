# Tangent with optional degree input.

function Get-CalcTan {
    param(
        [double] $Value,
        [switch] $Degrees
    )
    if ($Degrees) {
        $Value = $Value * [Math]::PI / 180.0
    }
    return [Math]::Tan($Value)
}
