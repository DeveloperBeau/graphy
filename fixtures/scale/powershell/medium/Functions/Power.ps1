# Exponentiation.

function Get-CalcPower {
    [CmdletBinding()]
    param(
        [double] $Base,
        [double] $Exponent
    )
    return [Math]::Pow($Base, $Exponent)
}
