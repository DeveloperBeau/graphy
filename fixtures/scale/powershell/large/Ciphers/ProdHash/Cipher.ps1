# ProdHash: multiply-accumulate digest (x31).

function Get-ProdHashDigest {
    param([byte[]] $Data)
    $h = [long]7
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $h = ($h * 31 + $Data[$i]) -band 0xFFFFFFFFL
    }
    return $h
}

function Get-ProdHashHex {
    param([byte[]] $Data)
    return "{0:x8}" -f (Get-ProdHashDigest -Data $Data)
}
