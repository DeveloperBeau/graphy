# XorShift cipher: xor against a 16-bit xorshift key stream.

$script:XorShiftSeed = 911

function Get-XorShiftKeyByte {
    $s = $script:XorShiftState
    $s = ($s -bxor ($s -shl 3)) -band 65535
    $s = ($s -bxor ($s -shr 5)) -band 65535
    $script:XorShiftState = $s
    return $s % 256
}

function Invoke-XorShiftEncrypt {
    param([byte[]] $Data)
    $script:XorShiftState = $script:XorShiftSeed
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = Get-XorShiftKeyByte
        $out[$i] = $Data[$i] -bxor $k
    }
    return $out
}

function Invoke-XorShiftDecrypt {
    param([byte[]] $Data)
    # Xor stream ciphers are symmetric.
    return Invoke-XorShiftEncrypt -Data $Data
}
