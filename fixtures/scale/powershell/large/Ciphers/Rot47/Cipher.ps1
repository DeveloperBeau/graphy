# Rot47 cipher: fixed +47 byte rotation.

function Invoke-Rot47Encrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 47) % 256
    }
    return $out
}

function Invoke-Rot47Decrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = ($Data[$i] + 209) % 256
    }
    return $out
}
