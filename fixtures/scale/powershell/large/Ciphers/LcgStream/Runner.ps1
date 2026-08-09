# Benchmark runner for the lcgstream cipher.

. ./Ciphers/LcgStream/Cipher.ps1
. ./Ciphers/LcgStream/Keys.ps1

function Invoke-LcgStreamBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-LcgStreamEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-LcgStreamBenchLabel {
    param([int] $Rounds = 16)
    return "lcgstream x$Rounds"
}
