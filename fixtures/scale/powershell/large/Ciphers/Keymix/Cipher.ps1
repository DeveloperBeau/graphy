# Keymix cipher: repeating key "ZEBRA" mixed into the byte stream.

$script:KeymixKey = "ZEBRA"

function Invoke-KeymixEncrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:KeymixKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + $k + 7) % 256
    }
    return $out
}

function Invoke-KeymixDecrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:KeymixKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + 512 - $k - 7) % 256
    }
    return $out
}
