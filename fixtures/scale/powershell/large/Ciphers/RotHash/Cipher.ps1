# RotHash: rotate-xor digest.

function Get-RotHashDigest {
    param([byte[]] $Data)
    $h = [long]99991
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $h = ((($h -shl 5) -bor ($h -shr 27)) -bxor $Data[$i]) -band 0xFFFFFFFFL
    }
    return $h
}

function Get-RotHashHex {
    param([byte[]] $Data)
    return "{0:x8}" -f (Get-RotHashDigest -Data $Data)
}
