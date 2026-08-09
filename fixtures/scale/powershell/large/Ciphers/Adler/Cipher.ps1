# Adler: two-accumulator checksum.

function Get-AdlerDigest {
    param([byte[]] $Data)
    $a = [long]1
    $b = [long]0
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $a = ($a + $Data[$i]) % 65521
        $b = ($b + $a) % 65521
    }
    return ($b -shl 16) -bor $a
}

function Get-AdlerHex {
    param([byte[]] $Data)
    return "{0:x8}" -f (Get-AdlerDigest -Data $Data)
}
