# Round-trip verification for the zigzag cipher.

. ./Ciphers/ZigZag/Cipher.ps1

function Test-ZigZagRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-ZigZagEncrypt -Data $Sample
    $decrypted = Invoke-ZigZagDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-ZigZagCheckLabel {
    return "verify:zigzag"
}
