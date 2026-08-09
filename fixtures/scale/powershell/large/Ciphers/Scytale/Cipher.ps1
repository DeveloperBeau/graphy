# Scytale cipher: block transposition with period 6.

$script:ScytalePerm = @(0, 3, 1, 4, 2, 5)
$script:ScytaleInv = @(0, 2, 4, 1, 3, 5)

function Invoke-ScytalePermute {
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

function Invoke-ScytaleEncrypt {
    param([byte[]] $Data)
    return Invoke-ScytalePermute -Data $Data -Order $script:ScytalePerm
}

function Invoke-ScytaleDecrypt {
    param([byte[]] $Data)
    return Invoke-ScytalePermute -Data $Data -Order $script:ScytaleInv
}
