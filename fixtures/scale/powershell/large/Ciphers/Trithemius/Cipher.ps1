# Trithemius cipher: repeating key "ABC" mixed into the byte stream.

$script:TrithemiusKey = "ABC"

function Invoke-TrithemiusEncrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:TrithemiusKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + $k + $i) % 256
    }
    return $out
}

function Invoke-TrithemiusDecrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:TrithemiusKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + 512 - $k - ($i % 256)) % 256
    }
    return $out
}
