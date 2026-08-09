# RailFence cipher: block transposition with period 6.

$script:RailFencePerm = @(0, 2, 4, 1, 3, 5)
$script:RailFenceInv = @(0, 3, 1, 4, 2, 5)

function Invoke-RailFencePermute {
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

function Invoke-RailFenceEncrypt {
    param([byte[]] $Data)
    return Invoke-RailFencePermute -Data $Data -Order $script:RailFencePerm
}

function Invoke-RailFenceDecrypt {
    param([byte[]] $Data)
    return Invoke-RailFencePermute -Data $Data -Order $script:RailFenceInv
}
