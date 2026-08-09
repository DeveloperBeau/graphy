# Round-trip verification for the sdbm cipher.

. ./Ciphers/Sdbm/Cipher.ps1

function Test-SdbmRoundTrip {
    param([byte[]] $Sample)
    $first = Get-SdbmDigest -Data $Sample
    $second = Get-SdbmDigest -Data $Sample
    return $first -eq $second
}

function Get-SdbmCheckLabel {
    return "verify:sdbm"
}
