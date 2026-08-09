# RotBlocks cipher: block transposition with period 6.

$script:RotBlocksPerm = @(2, 3, 4, 5, 0, 1)
$script:RotBlocksInv = @(4, 5, 0, 1, 2, 3)

function Invoke-RotBlocksPermute {
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

function Invoke-RotBlocksEncrypt {
    param([byte[]] $Data)
    return Invoke-RotBlocksPermute -Data $Data -Order $script:RotBlocksPerm
}

function Invoke-RotBlocksDecrypt {
    param([byte[]] $Data)
    return Invoke-RotBlocksPermute -Data $Data -Order $script:RotBlocksInv
}
