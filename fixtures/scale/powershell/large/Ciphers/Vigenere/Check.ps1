# Round-trip verification for the vigenere cipher.

. ./Ciphers/Vigenere/Cipher.ps1

function Test-VigenereRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-VigenereEncrypt -Data $Sample
    $decrypted = Invoke-VigenereDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-VigenereCheckLabel {
    return "verify:vigenere"
}
