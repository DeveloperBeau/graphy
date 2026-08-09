# Benchmark runner for the decimation cipher.

. ./Ciphers/Decimation/Cipher.ps1
. ./Ciphers/Decimation/Keys.ps1

function Invoke-DecimationBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-DecimationEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-DecimationBenchLabel {
    param([int] $Rounds = 16)
    return "decimation x$Rounds"
}
