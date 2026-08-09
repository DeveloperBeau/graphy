# Round-trip verification for the adler cipher.

. ./Ciphers/Adler/Cipher.ps1

function Test-AdlerRoundTrip {
    param([byte[]] $Sample)
    $first = Get-AdlerDigest -Data $Sample
    $second = Get-AdlerDigest -Data $Sample
    return $first -eq $second
}

function Get-AdlerCheckLabel {
    return "verify:adler"
}
