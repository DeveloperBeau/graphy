# Addmod cipher: fixed +17 byte rotation.

function Invoke-AddmodEncrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 17) % 256
    }
    return $out
}

function Invoke-AddmodDecrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 239) % 256
    }
    return $out
}
