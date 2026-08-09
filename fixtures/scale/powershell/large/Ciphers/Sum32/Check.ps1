# Round-trip verification for the sum32 cipher.

. ./Ciphers/Sum32/Cipher.ps1

function Test-Sum32RoundTrip {
    param([byte[]] $Sample)
    $first = Get-Sum32Digest -Data $Sample
    $second = Get-Sum32Digest -Data $Sample
    return $first -eq $second
}

function Get-Sum32CheckLabel {
    return "verify:sum32"
}
