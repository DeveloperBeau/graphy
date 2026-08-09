# Interleave cipher: block transposition with period 8.

$script:InterleavePerm = @(0, 2, 4, 6, 1, 3, 5, 7)
$script:InterleaveInv = @(0, 4, 1, 5, 2, 6, 3, 7)

function Invoke-InterleavePermute {
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

function Invoke-InterleaveEncrypt {
    param([byte[]] $Data)
    return Invoke-InterleavePermute -Data $Data -Order $script:InterleavePerm
}

function Invoke-InterleaveDecrypt {
    param([byte[]] $Data)
    return Invoke-InterleavePermute -Data $Data -Order $script:InterleaveInv
}
