# Round-trip verification for the affine cipher.

. ./Ciphers/Affine/Cipher.ps1

function Test-AffineRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-AffineEncrypt -Data $Sample
    $decrypted = Invoke-AffineDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-AffineCheckLabel {
    return "verify:affine"
}
