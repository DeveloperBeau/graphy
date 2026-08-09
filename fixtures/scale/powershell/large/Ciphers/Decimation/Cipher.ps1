# Decimation cipher: affine map 7x+0 over bytes.

function Invoke-DecimationEncrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = (7 * $Data[$i] + 0) % 256
    }
    return $out
}

function Invoke-DecimationDecrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = (183 * ($Data[$i] + 256 - 0)) % 256
    }
    return $out
}
