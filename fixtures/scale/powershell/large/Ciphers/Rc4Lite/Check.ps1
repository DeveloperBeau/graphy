# Round-trip verification for the rc4lite cipher.

. ./Ciphers/Rc4Lite/Cipher.ps1

function Test-Rc4LiteRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-Rc4LiteEncrypt -Data $Sample
    $decrypted = Invoke-Rc4LiteDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-Rc4LiteCheckLabel {
    return "verify:rc4lite"
}
