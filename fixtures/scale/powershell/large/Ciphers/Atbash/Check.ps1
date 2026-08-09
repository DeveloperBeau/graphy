# Round-trip verification for the atbash cipher.

. ./Ciphers/Atbash/Cipher.ps1

function Test-AtbashRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-AtbashEncrypt -Data $Sample
    $decrypted = Invoke-AtbashDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-AtbashCheckLabel {
    return "verify:atbash"
}
