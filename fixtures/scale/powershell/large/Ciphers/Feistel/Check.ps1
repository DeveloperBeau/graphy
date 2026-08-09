# Round-trip verification for the feistel cipher.

. ./Ciphers/Feistel/Cipher.ps1

function Test-FeistelRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-FeistelEncrypt -Data $Sample
    $decrypted = Invoke-FeistelDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-FeistelCheckLabel {
    return "verify:feistel"
}
