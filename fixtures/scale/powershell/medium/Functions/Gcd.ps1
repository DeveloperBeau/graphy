# Greatest common divisor (Euclid).

function Get-CalcGcd {
    param(
        [long] $A,
        [long] $B
    )
    $A = [Math]::Abs($A)
    $B = [Math]::Abs($B)
    while ($B -ne 0) {
        $A, $B = $B, ($A % $B)
    }
    return $A
}
