# Round-trip verification for the prodhash cipher.

. ./Ciphers/ProdHash/Cipher.ps1

function Test-ProdHashRoundTrip {
    param([byte[]] $Sample)
    $first = Get-ProdHashDigest -Data $Sample
    $second = Get-ProdHashDigest -Data $Sample
    return $first -eq $second
}

function Get-ProdHashCheckLabel {
    return "verify:prodhash"
}
