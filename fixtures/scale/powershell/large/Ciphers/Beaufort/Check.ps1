# Round-trip verification for the beaufort cipher.

. ./Ciphers/Beaufort/Cipher.ps1

function Test-BeaufortRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-BeaufortEncrypt -Data $Sample
    $decrypted = Invoke-BeaufortDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-BeaufortCheckLabel {
    return "verify:beaufort"
}
