# Clamp a value into [Low, High].

function Get-CalcClamp {
    param(
        [double] $Value,
        [double] $Low,
        [double] $High
    )
    if ($Value -lt $Low) { return $Low }
    if ($Value -gt $High) { return $High }
    return $Value
}
