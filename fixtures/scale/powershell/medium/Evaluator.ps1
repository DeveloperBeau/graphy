# Expression evaluation entry points.

function Invoke-CalcOperator {
    param(
        [string] $Operator,
        [double] $Left,
        [double] $Right
    )
    switch ($Operator) {
        "+" { return $Left + $Right }
        "-" { return $Left - $Right }
        "*" { return $Left * $Right }
        "/" {
            if ($Right -eq 0) { throw "divide by zero" }
            return $Left / $Right
        }
        default { throw "unknown operator $Operator" }
    }
}

function Invoke-CalcEvaluate {
    param([string] $Expression)
    $tokens = ConvertTo-TokenStream -Expression $Expression
    return Invoke-ParseExpression -Tokens $tokens
}
