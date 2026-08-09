# Round-trip verification for the railfence cipher.

. ./Ciphers/RailFence/Cipher.ps1

function Test-RailFenceRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-RailFenceEncrypt -Data $Sample
    $decrypted = Invoke-RailFenceDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-RailFenceCheckLabel {
    return "verify:railfence"
}
