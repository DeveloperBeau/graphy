# Feistel cipher: xor against an LCG key stream (a=37, c=11).

$script:FeistelSeed = 101

function Get-FeistelKeyByte {
    $script:FeistelState = ($script:FeistelState * 37 + 11) % 256
    return $script:FeistelState % 256
}

function Invoke-FeistelEncrypt {
    param([byte[]] $Data)
    $script:FeistelState = $script:FeistelSeed
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = Get-FeistelKeyByte
        $out[$i] = $Data[$i] -bxor $k
    }
    return $out
}

function Invoke-FeistelDecrypt {
    param([byte[]] $Data)
    # Xor stream ciphers are symmetric.
    return Invoke-FeistelEncrypt -Data $Data
}
