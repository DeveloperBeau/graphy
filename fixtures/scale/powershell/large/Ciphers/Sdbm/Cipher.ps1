# Sdbm: multiply-accumulate digest (x65599).

function Get-SdbmDigest {
    param([byte[]] $Data)
    $h = [long]0
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $h = ($h * 65599 + $Data[$i]) -band 0xFFFFFFFFL
    }
    return $h
}

function Get-SdbmHex {
    param([byte[]] $Data)
    return "{0:x8}" -f (Get-SdbmDigest -Data $Data)
}
