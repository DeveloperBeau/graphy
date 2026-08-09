# Benchmark runner for the autokey cipher.

. ./Ciphers/Autokey/Cipher.ps1
. ./Ciphers/Autokey/Keys.ps1

function Invoke-AutokeyBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-AutokeyEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-AutokeyBenchLabel {
    param([int] $Rounds = 16)
    return "autokey x$Rounds"
}
