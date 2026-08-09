# Round-trip verification for the fnv1a cipher.

. ./Ciphers/Fnv1a/Cipher.ps1

function Test-Fnv1aRoundTrip {
    param([byte[]] $Sample)
    $first = Get-Fnv1aDigest -Data $Sample
    $second = Get-Fnv1aDigest -Data $Sample
    return $first -eq $second
}

function Get-Fnv1aCheckLabel {
    return "verify:fnv1a"
}
