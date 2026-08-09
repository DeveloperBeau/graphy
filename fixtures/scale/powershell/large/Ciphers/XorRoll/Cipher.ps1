# XorRoll cipher: xor against an LCG key stream (a=75, c=74).

$script:XorRollSeed = 193

function Get-XorRollKeyByte {
    $script:XorRollState = ($script:XorRollState * 75 + 74) % 65537
    return $script:XorRollState % 256
}

function Invoke-XorRollEncrypt {
    param([byte[]] $Data)
    $script:XorRollState = $script:XorRollSeed
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = Get-XorRollKeyByte
        $out[$i] = $Data[$i] -bxor $k
    }
    return $out
}

function Invoke-XorRollDecrypt {
    param([byte[]] $Data)
    # Xor stream ciphers are symmetric.
    return Invoke-XorRollEncrypt -Data $Data
}
