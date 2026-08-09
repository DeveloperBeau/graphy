# Rot13 cipher: fixed +13 byte rotation.

function Invoke-Rot13Encrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 13) % 256
    }
    return $out
}

function Invoke-Rot13Decrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 243) % 256
    }
    return $out
}
