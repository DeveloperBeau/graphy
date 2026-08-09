# Round-trip verification for the gronsfeld cipher.

. ./Ciphers/Gronsfeld/Cipher.ps1

function Test-GronsfeldRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-GronsfeldEncrypt -Data $Sample
    $decrypted = Invoke-GronsfeldDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-GronsfeldCheckLabel {
    return "verify:gronsfeld"
}
