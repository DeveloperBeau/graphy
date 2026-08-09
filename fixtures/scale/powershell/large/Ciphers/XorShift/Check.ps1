# Round-trip verification for the xorshift cipher.

. ./Ciphers/XorShift/Cipher.ps1

function Test-XorShiftRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-XorShiftEncrypt -Data $Sample
    $decrypted = Invoke-XorShiftDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-XorShiftCheckLabel {
    return "verify:xorshift"
}
