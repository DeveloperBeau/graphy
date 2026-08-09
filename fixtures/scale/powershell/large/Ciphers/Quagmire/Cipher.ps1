# Quagmire cipher: repeating key "OCEAN" mixed into the byte stream.

$script:QuagmireKey = "OCEAN"

function Invoke-QuagmireEncrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:QuagmireKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + $k + 11) % 256
    }
    return $out
}

function Invoke-QuagmireDecrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:QuagmireKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + 512 - $k - 11) % 256
    }
    return $out
}
