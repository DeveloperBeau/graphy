# Linear interpolation between two values.

function Get-CalcLerp {
    param(
        [double] $From,
        [double] $To,
        [double] $T
    )
    return $From + ($To - $From) * $T
}
