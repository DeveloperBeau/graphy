# CrcLite: shift-xor checksum.

function Get-CrcLiteDigest {
    param([byte[]] $Data)
    $h = [long]4294967295
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $h = (($h -shr 1) -bxor (($h -band 1) * 3988292384) -bxor $Data[$i]) -band 0xFFFFFFFFL
    }
    return $h
}

function Get-CrcLiteHex {
    param([byte[]] $Data)
    return "{0:x8}" -f (Get-CrcLiteDigest -Data $Data)
}
