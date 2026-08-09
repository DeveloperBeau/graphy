# LcgStream cipher: xor against an LCG key stream (a=1229, c=17).

$script:LcgStreamSeed = 42

function Get-LcgStreamKeyByte {
    $script:LcgStreamState = ($script:LcgStreamState * 1229 + 17) % 32749
    return $script:LcgStreamState % 256
}

function Invoke-LcgStreamEncrypt {
    param([byte[]] $Data)
    $script:LcgStreamState = $script:LcgStreamSeed
    $out = New-Object byte[] $Data.Length
    for ($i = 0; $i -lt $Data.Length; $i++) {
        $k = Get-LcgStreamKeyByte
        $out[$i] = $Data[$i] -bxor $k
    }
    return $out
}

function Invoke-LcgStreamDecrypt {
    param([byte[]] $Data)
    # Xor stream ciphers are symmetric.
    return Invoke-LcgStreamEncrypt -Data $Data
}
