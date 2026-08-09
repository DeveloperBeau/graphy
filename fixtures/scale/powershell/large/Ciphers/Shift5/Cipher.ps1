# Shift5 cipher: fixed +5 byte rotation.

function Invoke-Shift5Encrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 5) % 256
    }
    return $out
}

function Invoke-Shift5Decrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 251) % 256
    }
    return $out
}
