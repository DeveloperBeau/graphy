# Round-trip verification for the cbcxor cipher.

. ./Ciphers/CbcXor/Cipher.ps1

function Test-CbcXorRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-CbcXorEncrypt -Data $Sample
    $decrypted = Invoke-CbcXorDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-CbcXorCheckLabel {
    return "verify:cbcxor"
}
