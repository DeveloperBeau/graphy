# Round-trip verification for the caesar cipher.

. ./Ciphers/Caesar/Cipher.ps1

function Test-CaesarRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-CaesarEncrypt -Data $Sample
    $decrypted = Invoke-CaesarDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-CaesarCheckLabel {
    return "verify:caesar"
}
