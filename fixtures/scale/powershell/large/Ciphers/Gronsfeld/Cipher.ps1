# Gronsfeld cipher: repeating key "31415" mixed into the byte stream.

$script:GronsfeldKey = "31415"

function Invoke-GronsfeldEncrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:GronsfeldKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + $k) % 256
    }
    return $out
}

function Invoke-GronsfeldDecrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:GronsfeldKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + 256 - $k) % 256
    }
    return $out
}
