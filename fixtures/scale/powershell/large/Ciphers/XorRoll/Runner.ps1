# Benchmark runner for the xorroll cipher.

. ./Ciphers/XorRoll/Cipher.ps1
. ./Ciphers/XorRoll/Keys.ps1

function Invoke-XorRollBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-XorRollEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-XorRollBenchLabel {
    param([int] $Rounds = 16)
    return "xorroll x$Rounds"
}
