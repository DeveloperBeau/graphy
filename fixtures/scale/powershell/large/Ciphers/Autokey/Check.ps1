# Round-trip verification for the autokey cipher.

. ./Ciphers/Autokey/Cipher.ps1

function Test-AutokeyRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-AutokeyEncrypt -Data $Sample
    $decrypted = Invoke-AutokeyDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-AutokeyCheckLabel {
    return "verify:autokey"
}
