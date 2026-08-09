# Round-trip verification for the xorroll cipher.

. ./Ciphers/XorRoll/Cipher.ps1

function Test-XorRollRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-XorRollEncrypt -Data $Sample
    $decrypted = Invoke-XorRollDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-XorRollCheckLabel {
    return "verify:xorroll"
}
