# Benchmark runner for the prodhash cipher.

. ./Ciphers/ProdHash/Cipher.ps1
. ./Ciphers/ProdHash/Keys.ps1

function Invoke-ProdHashBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Get-ProdHashDigest -Data $Sample
    }
    return $out.Length
}

function Get-ProdHashBenchLabel {
    param([int] $Rounds = 16)
    return "prodhash x$Rounds"
}
