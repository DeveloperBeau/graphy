# Multiplicative inverse.

function Get-CalcReciprocal {
    [CmdletBinding()]
    param([double] $Value)
    if ($Value -eq 0) {
        throw "reciprocal of zero"
    }
    return 1.0 / $Value
}
