# XorBasic cipher: xor against a fixed 1-byte mask.

$script:XorBasicMask = @(90)

function Get-XorBasicKeyByte {
    param([int] $Index)
    return $script:XorBasicMask[$Index % $script:XorBasicMask.Count]
}

function Invoke-XorBasicEncrypt {
    param([byte[]] $Data)
    # stateless mask stream
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = Get-XorBasicKeyByte -Index $i
        $out[$i] = $Data[$i] -bxor $k
    }
    return $out
}

function Invoke-XorBasicDecrypt {
    param([byte[]] $Data)
    # Xor stream ciphers are symmetric.
    return Invoke-XorBasicEncrypt -Data $Data
}
