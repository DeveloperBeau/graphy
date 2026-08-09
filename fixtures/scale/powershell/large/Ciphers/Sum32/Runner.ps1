# Benchmark runner for the sum32 cipher.

. ./Ciphers/Sum32/Cipher.ps1
. ./Ciphers/Sum32/Keys.ps1

function Invoke-Sum32Bench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Get-Sum32Digest -Data $Sample
    }
    return $out.Length
}

function Get-Sum32BenchLabel {
    param([int] $Rounds = 16)
    return "sum32 x$Rounds"
}
