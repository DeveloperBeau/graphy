# Round-trip verification for the xorbasic cipher.

. ./Ciphers/XorBasic/Cipher.ps1

function Test-XorBasicRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-XorBasicEncrypt -Data $Sample
    $decrypted = Invoke-XorBasicDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-XorBasicCheckLabel {
    return "verify:xorbasic"
}
