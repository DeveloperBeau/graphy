# Atbash cipher: mirror each byte across the range.

function Invoke-AtbashEncrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = 255 - $Data[$i]
    }
    return $out
}

function Invoke-AtbashDecrypt {
    param([byte[]] $Data)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $out[$i] = 255 - $Data[$i]
    }
    return $out
}
