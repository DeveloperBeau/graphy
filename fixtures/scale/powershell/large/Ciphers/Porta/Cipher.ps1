# Porta cipher: repeating key "GLACIER" mixed into the byte stream.

$script:PortaKey = "GLACIER"

function Invoke-PortaEncrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:PortaKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($k + 256 - $Data[$i]) % 256
    }
    return $out
}

function Invoke-PortaDecrypt {
    param([byte[]] $Data)
    # Subtraction against the key stream is its own inverse.
    return Invoke-PortaEncrypt -Data $Data
}
