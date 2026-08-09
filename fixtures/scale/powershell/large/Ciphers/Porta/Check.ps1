# Round-trip verification for the porta cipher.

. ./Ciphers/Porta/Cipher.ps1

function Test-PortaRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-PortaEncrypt -Data $Sample
    $decrypted = Invoke-PortaDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-PortaCheckLabel {
    return "verify:porta"
}
