# CtrXor cipher: xor against an LCG key stream (a=1, c=1).

$script:CtrXorSeed = 7

function Get-CtrXorKeyByte {
    $script:CtrXorState = ($script:CtrXorState * 1 + 1) % 256
    return $script:CtrXorState % 256
}

function Invoke-CtrXorEncrypt {
    param([byte[]] $Data)
    $script:CtrXorState = $script:CtrXorSeed
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = Get-CtrXorKeyByte
        $out[$i] = $Data[$i] -bxor $k
    }
    return $out
}

function Invoke-CtrXorDecrypt {
    param([byte[]] $Data)
    # Xor stream ciphers are symmetric.
    return Invoke-CtrXorEncrypt -Data $Data
}
