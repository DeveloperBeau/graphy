# ZigZag cipher: block transposition with period 2.

$script:ZigZagPerm = @(1, 0)
$script:ZigZagInv = @(1, 0)

function Invoke-ZigZagPermute {
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

function Invoke-ZigZagEncrypt {
    param([byte[]] $Data)
    return Invoke-ZigZagPermute -Data $Data -Order $script:ZigZagPerm
}

function Invoke-ZigZagDecrypt {
    param([byte[]] $Data)
    return Invoke-ZigZagPermute -Data $Data -Order $script:ZigZagInv
}
