# Round-trip verification for the stride cipher.

. ./Ciphers/Stride/Cipher.ps1

function Test-StrideRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-StrideEncrypt -Data $Sample
    $decrypted = Invoke-StrideDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-StrideCheckLabel {
    return "verify:stride"
}
