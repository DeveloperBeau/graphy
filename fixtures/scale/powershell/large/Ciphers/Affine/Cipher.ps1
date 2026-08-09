# Affine cipher: affine map 5x+8 over bytes.

function Invoke-AffineEncrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = (5 * $Data[$i] + 8) % 256
    }
    return $out
}

function Invoke-AffineDecrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = (205 * ($Data[$i] + 256 - 8)) % 256
    }
    return $out
}
