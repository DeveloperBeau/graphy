# Benchmark runner for the feistel cipher.

. ./Ciphers/Feistel/Cipher.ps1
. ./Ciphers/Feistel/Keys.ps1

function Invoke-FeistelBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-FeistelEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-FeistelBenchLabel {
    param([int] $Rounds = 16)
    return "feistel x$Rounds"
}
