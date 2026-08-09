# Benchmark runner for the zigzag cipher.

. ./Ciphers/ZigZag/Cipher.ps1
. ./Ciphers/ZigZag/Keys.ps1

function Invoke-ZigZagBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-ZigZagEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-ZigZagBenchLabel {
    param([int] $Rounds = 16)
    return "zigzag x$Rounds"
}
