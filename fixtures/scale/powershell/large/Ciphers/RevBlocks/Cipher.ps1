# RevBlocks cipher: block transposition with period 4.

$script:RevBlocksPerm = @(3, 2, 1, 0)
$script:RevBlocksInv = @(3, 2, 1, 0)

function Invoke-RevBlocksPermute {
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

function Invoke-RevBlocksEncrypt {
    param([byte[]] $Data)
    return Invoke-RevBlocksPermute -Data $Data -Order $script:RevBlocksPerm
}

function Invoke-RevBlocksDecrypt {
    param([byte[]] $Data)
    return Invoke-RevBlocksPermute -Data $Data -Order $script:RevBlocksInv
}
