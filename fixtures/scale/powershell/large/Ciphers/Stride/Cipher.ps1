# Stride cipher: block transposition with period 9.

$script:StridePerm = @(0, 3, 6, 1, 4, 7, 2, 5, 8)
$script:StrideInv = @(0, 3, 6, 1, 4, 7, 2, 5, 8)

function Invoke-StridePermute {
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

function Invoke-StrideEncrypt {
    param([byte[]] $Data)
    return Invoke-StridePermute -Data $Data -Order $script:StridePerm
}

function Invoke-StrideDecrypt {
    param([byte[]] $Data)
    return Invoke-StridePermute -Data $Data -Order $script:StrideInv
}
