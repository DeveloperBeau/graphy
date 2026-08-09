# XorDigest: position-spread xor digest.

function Get-XorDigestDigest {
    param([byte[]] $Data)
    $h = [long]0
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $h = ($h -bxor ([long]$Data[$i] -shl (($i % 4) * 8))) -band 0xFFFFFFFFL
    }
    return $h
}

function Get-XorDigestHex {
    param([byte[]] $Data)
    return "{0:x8}" -f (Get-XorDigestDigest -Data $Data)
}
