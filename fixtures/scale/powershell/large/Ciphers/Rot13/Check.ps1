# Round-trip verification for the rot13 cipher.

. ./Ciphers/Rot13/Cipher.ps1

function Test-Rot13RoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-Rot13Encrypt -Data $Sample
    $decrypted = Invoke-Rot13Decrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-Rot13CheckLabel {
    return "verify:rot13"
}
