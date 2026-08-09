# Benchmark runner for the ctrxor cipher.

. ./Ciphers/CtrXor/Cipher.ps1
. ./Ciphers/CtrXor/Keys.ps1

function Invoke-CtrXorBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-CtrXorEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-CtrXorBenchLabel {
    param([int] $Rounds = 16)
    return "ctrxor x$Rounds"
}
