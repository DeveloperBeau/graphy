# Benchmark runner for the atbash cipher.

. ./Ciphers/Atbash/Cipher.ps1
. ./Ciphers/Atbash/Keys.ps1

function Invoke-AtbashBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-AtbashEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-AtbashBenchLabel {
    param([int] $Rounds = 16)
    return "atbash x$Rounds"
}
