# Djb2: multiply-accumulate digest (x33).

function Get-Djb2Digest {
    param([byte[]] $Data)
    $h = [long]5381
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $h = ($h * 33 + $Data[$i]) -band 0xFFFFFFFFL
    }
    return $h
}

function Get-Djb2Hex {
    param([byte[]] $Data)
    return "{0:x8}" -f (Get-Djb2Digest -Data $Data)
}
