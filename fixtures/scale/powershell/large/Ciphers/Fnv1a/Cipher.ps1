# Fnv1a: xor-then-multiply digest.

function Get-Fnv1aDigest {
    param([byte[]] $Data)
    $h = [long]2166136261
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $h = (($h -bxor $Data[$i]) * 16777619) -band 0xFFFFFFFFL
    }
    return $h
}

function Get-Fnv1aHex {
    param([byte[]] $Data)
    return "{0:x8}" -f (Get-Fnv1aDigest -Data $Data)
}
