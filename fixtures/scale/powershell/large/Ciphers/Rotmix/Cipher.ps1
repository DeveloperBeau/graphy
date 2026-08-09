# Rotmix cipher: position-salted shift of +3.

function Invoke-RotmixEncrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 3 + $i) % 256
    }
    return $out
}

function Invoke-RotmixDecrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 512 - 3 - ($i % 256)) % 256
    }
    return $out
}
