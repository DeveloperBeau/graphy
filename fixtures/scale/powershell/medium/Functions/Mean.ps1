# Arithmetic mean of a value list.

function Get-CalcMean {
    param([double[]] $Values)
    if ($Values.Count -eq 0) {
        throw "mean of an empty list"
    }
    $sum = 0.0
    foreach ($v in $Values) {
        $sum += $v
    }
    return $sum / $Values.Count
}
