# Split an expression string into a token queue.

function Read-NumberToken {
    param(
        [string] $Expression,
        [int] $Start
    )
    $end = $Start
    while ($end -lt $Expression.Length -and ($Expression[$end] -match '[0-9.]')) {
        $end++
    }
    return @{ Text = $Expression.Substring($Start, $end - $Start); Next = $end }
}

function ConvertTo-TokenStream {
    param([string] $Expression)
    $tokens = New-Object System.Collections.Queue
    $i = 0
    while ($i -lt $Expression.Length) {
        $c = $Expression[$i]
        if ($c -eq " ") { $i++; continue }
        if ($c -match '[0-9]') {
            $num = Read-NumberToken -Expression $Expression -Start $i
            $tokens.Enqueue((New-CalcToken -Type "NUM" -Value $num.Text))
            $i = $num.Next
        } else {
            $tokens.Enqueue((New-CalcToken -Type "OP" -Value "$c"))
            $i++
        }
    }
    return $tokens
}
