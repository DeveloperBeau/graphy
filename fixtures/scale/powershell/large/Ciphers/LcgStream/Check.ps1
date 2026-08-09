# Round-trip verification for the lcgstream cipher.

. ./Ciphers/LcgStream/Cipher.ps1

function Test-LcgStreamRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-LcgStreamEncrypt -Data $Sample
    $decrypted = Invoke-LcgStreamDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-LcgStreamCheckLabel {
    return "verify:lcgstream"
}
