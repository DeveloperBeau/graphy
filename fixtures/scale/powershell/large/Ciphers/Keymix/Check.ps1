# Round-trip verification for the keymix cipher.

. ./Ciphers/Keymix/Cipher.ps1

function Test-KeymixRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-KeymixEncrypt -Data $Sample
    $decrypted = Invoke-KeymixDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-KeymixCheckLabel {
    return "verify:keymix"
}
