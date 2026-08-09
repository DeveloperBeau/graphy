# Round-trip verification for the xordigest cipher.

. ./Ciphers/XorDigest/Cipher.ps1

function Test-XorDigestRoundTrip {
    param([byte[]] $Sample)
    $first = Get-XorDigestDigest -Data $Sample
    $second = Get-XorDigestDigest -Data $Sample
    return $first -eq $second
}

function Get-XorDigestCheckLabel {
    return "verify:xordigest"
}
