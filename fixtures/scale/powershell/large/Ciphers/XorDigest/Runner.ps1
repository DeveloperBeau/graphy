# Benchmark runner for the xordigest cipher.

. ./Ciphers/XorDigest/Cipher.ps1
. ./Ciphers/XorDigest/Keys.ps1

function Invoke-XorDigestBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Get-XorDigestDigest -Data $Sample
    }
    return $out.Length
}

function Get-XorDigestBenchLabel {
    param([int] $Rounds = 16)
    return "xordigest x$Rounds"
}
