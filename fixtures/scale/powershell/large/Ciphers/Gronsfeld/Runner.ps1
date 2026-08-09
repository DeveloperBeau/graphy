# Benchmark runner for the gronsfeld cipher.

. ./Ciphers/Gronsfeld/Cipher.ps1
. ./Ciphers/Gronsfeld/Keys.ps1

function Invoke-GronsfeldBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-GronsfeldEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-GronsfeldBenchLabel {
    param([int] $Rounds = 16)
    return "gronsfeld x$Rounds"
}
