# CbcXor cipher: xor chained against the previous cipher byte.

$script:CbcXorIv = 113

function Get-CbcXorKeyByte {
    return $script:CbcXorPrev
}

function Invoke-CbcXorEncrypt {
    param([byte[]] $Data)
    $script:CbcXorPrev = $script:CbcXorIv
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = Get-CbcXorKeyByte
        $out[$i] = $Data[$i] -bxor $k
        $script:CbcXorPrev = $out[$i]
    }
    return $out
}

function Invoke-CbcXorDecrypt {
    param([byte[]] $Data)
    $prev = $script:CbcXorIv
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = $Data[$i] -bxor $prev
        $prev = $Data[$i]
    }
    return $out
}
