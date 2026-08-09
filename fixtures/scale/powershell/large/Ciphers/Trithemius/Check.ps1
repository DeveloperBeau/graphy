# Round-trip verification for the trithemius cipher.

. ./Ciphers/Trithemius/Cipher.ps1

function Test-TrithemiusRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-TrithemiusEncrypt -Data $Sample
    $decrypted = Invoke-TrithemiusDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-TrithemiusCheckLabel {
    return "verify:trithemius"
}
