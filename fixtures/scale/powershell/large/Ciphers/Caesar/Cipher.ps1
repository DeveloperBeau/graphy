# Caesar cipher: fixed +3 byte rotation.

function Invoke-CaesarEncrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 3) % 256
    }
    return $out
}

function Invoke-CaesarDecrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 253) % 256
    }
    return $out
}
