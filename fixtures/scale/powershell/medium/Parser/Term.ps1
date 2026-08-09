# Multiplicative term parsing.

function Test-MultiplicativeOperator {
    param($Tokens)
    if ($Tokens.Count -eq 0) { return $false }
    $head = $Tokens.Peek()
    return $head.Type -eq "OP" -and ($head.Value -eq "*" -or $head.Value -eq "/")
}

function Invoke-ParseTerm {
    param($Tokens)
    $left = Invoke-ParseFactor -Tokens $Tokens
    while (Test-MultiplicativeOperator -Tokens $Tokens) {
        $op = $Tokens.Dequeue().Value
        $right = Invoke-ParseFactor -Tokens $Tokens
        $left = Invoke-CalcOperator -Operator $op -Left $left -Right $right
    }
    return $left
}
