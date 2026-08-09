# Round-trip verification for the rotmix cipher.

. ./Ciphers/Rotmix/Cipher.ps1

function Test-RotmixRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-RotmixEncrypt -Data $Sample
    $decrypted = Invoke-RotmixDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-RotmixCheckLabel {
    return "verify:rotmix"
}
