# Euclidean distance from the origin.

function Get-CalcHypot {
    [CmdletBinding()]
    param(
        [double] $X,
        [double] $Y
    )
    return [Math]::Sqrt($X * $X + $Y * $Y)
}
