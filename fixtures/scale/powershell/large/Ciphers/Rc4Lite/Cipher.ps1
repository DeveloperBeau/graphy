# Rc4Lite cipher: xor against an LCG key stream (a=181, c=359).

$script:Rc4LiteSeed = 17

function Get-Rc4LiteKeyByte {
    $script:Rc4LiteState = ($script:Rc4LiteState * 181 + 359) % 65521
    return $script:Rc4LiteState % 256
}

function Invoke-Rc4LiteEncrypt {
    param([byte[]] $Data)
    $script:Rc4LiteState = $script:Rc4LiteSeed
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = Get-Rc4LiteKeyByte
        $out[$i] = $Data[$i] -bxor $k
    }
    return $out
}

function Invoke-Rc4LiteDecrypt {
    param([byte[]] $Data)
    # Xor stream ciphers are symmetric.
    return Invoke-Rc4LiteEncrypt -Data $Data
}
