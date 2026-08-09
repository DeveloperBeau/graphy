# Benchmark runner for the adler cipher.

. ./Ciphers/Adler/Cipher.ps1
. ./Ciphers/Adler/Keys.ps1

function Invoke-AdlerBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Get-AdlerDigest -Data $Sample
    }
    return $out.Length
}

function Get-AdlerBenchLabel {
    param([int] $Rounds = 16)
    return "adler x$Rounds"
}
