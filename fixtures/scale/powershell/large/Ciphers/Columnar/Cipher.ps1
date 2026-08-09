# Columnar cipher: block transposition with period 4.

$script:ColumnarPerm = @(3, 1, 0, 2)
$script:ColumnarInv = @(2, 1, 3, 0)

function Invoke-ColumnarPermute {
    param(
        [byte[]] $Data,
        [int[]] $Order
    )
    $out = New-Object byte[] $Data.Length
    $period = $Order.Count
    $base = 0
    while ($base + $period -le $Data.Length) {
        for ($j = 0; $j -lt $period; $j++) {
            $out[$base + $j] = $Data[$base + $Order[$j]]
        }
        $base += $period
    }
    for ($i = $base; $i -lt $Data.Length; $i++) {
        $out[$i] = $Data[$i]
    }
    return $out
}

function Invoke-ColumnarEncrypt {
    param([byte[]] $Data)
    return Invoke-ColumnarPermute -Data $Data -Order $script:ColumnarPerm
}

function Invoke-ColumnarDecrypt {
    param([byte[]] $Data)
    return Invoke-ColumnarPermute -Data $Data -Order $script:ColumnarInv
}
