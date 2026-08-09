# Autokey cipher: repeating key "QUEEN" mixed into the byte stream.

$script:AutokeyKey = "QUEEN"

function Invoke-AutokeyEncrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:AutokeyKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + $k) % 256
    }
    return $out
}

function Invoke-AutokeyDecrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:AutokeyKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + 256 - $k) % 256
    }
    return $out
}
