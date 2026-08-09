# Fibonacci number (iterative).

function Get-CalcFibonacci {
    param([int] $N)
    $a = [long]0
    $b = [long]1
    for ($i = 0; $i -lt $N; $i++) {
        $a, $b = $b, ($a + $b)
    }
    return $a
}
