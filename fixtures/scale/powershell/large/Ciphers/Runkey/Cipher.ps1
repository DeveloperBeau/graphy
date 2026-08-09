# Runkey cipher: repeating key "THEQUICKBROWNFOX" mixed into the byte stream.

$script:RunkeyKey = "THEQUICKBROWNFOX"

function Invoke-RunkeyEncrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:RunkeyKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + $k) % 256
    }
    return $out
}

function Invoke-RunkeyDecrypt {
    param([byte[]] $Data)
    $key = [System.Text.Encoding]::ASCII.GetBytes($script:RunkeyKey)
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = $key[$i % $key.Length]
        $out[$i] = ($Data[$i] + 256 - $k) % 256
    }
    return $out
}
