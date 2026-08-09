# Sum32: multiply-accumulate digest (x1).

function Get-Sum32Digest {
    param([byte[]] $Data)
    $h = [long]0
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $h = ($h * 1 + $Data[$i]) -band 0xFFFFFFFFL
    }
    return $h
}

function Get-Sum32Hex {
    param([byte[]] $Data)
    return "{0:x8}" -f (Get-Sum32Digest -Data $Data)
}
