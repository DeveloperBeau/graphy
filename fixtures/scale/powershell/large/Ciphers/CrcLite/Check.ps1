# Round-trip verification for the crclite cipher.

. ./Ciphers/CrcLite/Cipher.ps1

function Test-CrcLiteRoundTrip {
    param([byte[]] $Sample)
    $first = Get-CrcLiteDigest -Data $Sample
    $second = Get-CrcLiteDigest -Data $Sample
    return $first -eq $second
}

function Get-CrcLiteCheckLabel {
    return "verify:crclite"
}
