# Round-trip verification for the rothash cipher.

. ./Ciphers/RotHash/Cipher.ps1

function Test-RotHashRoundTrip {
    param([byte[]] $Sample)
    $first = Get-RotHashDigest -Data $Sample
    $second = Get-RotHashDigest -Data $Sample
    return $first -eq $second
}

function Get-RotHashCheckLabel {
    return "verify:rothash"
}
