# Factorial (iterative, integer domain).

function Get-CalcFactorial {
    param([int] $N)
    if ($N -lt 0) {
        throw "factorial of a negative number"
    }
    $acc = [long]1
    for ($i = 2; $i -le $N; $i++) {
        $acc *= $i
    }
    return $acc
}
