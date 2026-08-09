# Round-trip verification for the rot47 cipher.

. ./Ciphers/Rot47/Cipher.ps1

function Test-Rot47RoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-Rot47Encrypt -Data $Sample
    $decrypted = Invoke-Rot47Decrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-Rot47CheckLabel {
    return "verify:rot47"
}
