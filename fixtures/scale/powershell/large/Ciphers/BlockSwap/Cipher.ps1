# BlockSwap cipher: block transposition with period 8.

$script:BlockSwapPerm = @(4, 5, 6, 7, 0, 1, 2, 3)
$script:BlockSwapInv = @(4, 5, 6, 7, 0, 1, 2, 3)

function Invoke-BlockSwapPermute {
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

function Invoke-BlockSwapEncrypt {
    param([byte[]] $Data)
    return Invoke-BlockSwapPermute -Data $Data -Order $script:BlockSwapPerm
}

function Invoke-BlockSwapDecrypt {
    param([byte[]] $Data)
    return Invoke-BlockSwapPermute -Data $Data -Order $script:BlockSwapInv
}
