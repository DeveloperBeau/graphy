# Round-trip verification for the interleave cipher.

. ./Ciphers/Interleave/Cipher.ps1

function Test-InterleaveRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-InterleaveEncrypt -Data $Sample
    $decrypted = Invoke-InterleaveDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-InterleaveCheckLabel {
    return "verify:interleave"
}
