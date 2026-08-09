# Beaufort cipher: repeating key "FORTRESS" mixed into the byte stream.

$script:BeaufortKey = "FORTRESS"

function Invoke-BeaufortEncrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:BeaufortKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($k + 256 - $Data[$i]) % 256
    }
    return $out
}

function Invoke-BeaufortDecrypt {
    param([byte[]] $Data)
    # Subtraction against the key stream is its own inverse.
    return Invoke-BeaufortEncrypt -Data $Data
}
