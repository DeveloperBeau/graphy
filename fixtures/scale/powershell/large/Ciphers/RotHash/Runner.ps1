# Benchmark runner for the rothash cipher.

. ./Ciphers/RotHash/Cipher.ps1
. ./Ciphers/RotHash/Keys.ps1

function Invoke-RotHashBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Get-RotHashDigest -Data $Sample
    }
    return $out.Length
}

function Get-RotHashBenchLabel {
    param([int] $Rounds = 16)
    return "rothash x$Rounds"
}
