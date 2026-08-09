# Additive expression parsing.

function Test-AdditiveOperator {
    param($Tokens)
    if ($Tokens.Count -eq 0) { return $false }
    $head = $Tokens.Peek()
    return $head.Type -eq "OP" -and ($head.Value -eq "+" -or $head.Value -eq "-")
}

function Invoke-ParseExpression {
    param($Tokens)
    $left = Invoke-ParseTerm -Tokens $Tokens
    while (Test-AdditiveOperator -Tokens $Tokens) {
        $op = $Tokens.Dequeue().Value
        $right = Invoke-ParseTerm -Tokens $Tokens
        $left = Invoke-CalcOperator -Operator $op -Left $left -Right $right
    }
    return $left
}
