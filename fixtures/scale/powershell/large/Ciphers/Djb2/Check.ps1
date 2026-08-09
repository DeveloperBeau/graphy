# Round-trip verification for the djb2 cipher.

. ./Ciphers/Djb2/Cipher.ps1

function Test-Djb2RoundTrip {
    param([byte[]] $Sample)
    $first = Get-Djb2Digest -Data $Sample
    $second = Get-Djb2Digest -Data $Sample
    return $first -eq $second
}

function Get-Djb2CheckLabel {
    return "verify:djb2"
}
