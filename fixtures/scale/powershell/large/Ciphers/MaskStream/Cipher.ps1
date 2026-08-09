# MaskStream cipher: xor against a fixed 4-byte mask.

$script:MaskStreamMask = @(23, 105, 187, 7)

function Get-MaskStreamKeyByte {
    param([int] $Index)
    return $script:MaskStreamMask[$Index % $script:MaskStreamMask.Count]
}

function Invoke-MaskStreamEncrypt {
    param([byte[]] $Data)
    # stateless mask stream
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = Get-MaskStreamKeyByte -Index $i
        $out[$i] = $Data[$i] -bxor $k
    }
    return $out
}

function Invoke-MaskStreamDecrypt {
    param([byte[]] $Data)
    # Xor stream ciphers are symmetric.
    return Invoke-MaskStreamEncrypt -Data $Data
}
