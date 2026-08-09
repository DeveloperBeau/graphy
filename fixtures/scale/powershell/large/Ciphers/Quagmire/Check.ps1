# Round-trip verification for the quagmire cipher.

. ./Ciphers/Quagmire/Cipher.ps1

function Test-QuagmireRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-QuagmireEncrypt -Data $Sample
    $decrypted = Invoke-QuagmireDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-QuagmireCheckLabel {
    return "verify:quagmire"
}
