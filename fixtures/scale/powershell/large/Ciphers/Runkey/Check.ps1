# Round-trip verification for the runkey cipher.

. ./Ciphers/Runkey/Cipher.ps1

function Test-RunkeyRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-RunkeyEncrypt -Data $Sample
    $decrypted = Invoke-RunkeyDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-RunkeyCheckLabel {
    return "verify:runkey"
}
