# Round-trip verification for the scytale cipher.

. ./Ciphers/Scytale/Cipher.ps1

function Test-ScytaleRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-ScytaleEncrypt -Data $Sample
    $decrypted = Invoke-ScytaleDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-ScytaleCheckLabel {
    return "verify:scytale"
}
