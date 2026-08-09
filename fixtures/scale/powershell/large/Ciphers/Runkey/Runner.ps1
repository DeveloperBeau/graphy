# Benchmark runner for the runkey cipher.

. ./Ciphers/Runkey/Cipher.ps1
. ./Ciphers/Runkey/Keys.ps1

function Invoke-RunkeyBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-RunkeyEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-RunkeyBenchLabel {
    param([int] $Rounds = 16)
    return "runkey x$Rounds"
}
