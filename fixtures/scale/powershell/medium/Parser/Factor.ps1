# Numbers, unary minus and parenthesised groups.

function Invoke-ParseNegation {
    param($Tokens)
    return -(Invoke-ParseFactor -Tokens $Tokens)
}

function Invoke-ParseFactor {
    param($Tokens)
    if ($Tokens.Count -eq 0) { throw "unexpected end of expression" }
    $token = $Tokens.Dequeue()
    if ($token.Type -eq "NUM") {
        return [double]$token.Value
    }
    if ($token.Value -eq "-") {
        return Invoke-ParseNegation -Tokens $Tokens
    }
    if ($token.Value -eq "(") {
        $inner = Invoke-ParseExpression -Tokens $Tokens
        [void]$Tokens.Dequeue()
        return $inner
    }
    throw "unexpected token $($token.Describe())"
}
