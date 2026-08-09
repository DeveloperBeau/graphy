# Round-trip verification for the shift5 cipher.

. ./Ciphers/Shift5/Cipher.ps1

function Test-Shift5RoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-Shift5Encrypt -Data $Sample
    $decrypted = Invoke-Shift5Decrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-Shift5CheckLabel {
    return "verify:shift5"
}
