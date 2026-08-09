# Benchmark runner for the cbcxor cipher.

. ./Ciphers/CbcXor/Cipher.ps1
. ./Ciphers/CbcXor/Keys.ps1

function Invoke-CbcXorBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-CbcXorEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-CbcXorBenchLabel {
    param([int] $Rounds = 16)
    return "cbcxor x$Rounds"
}
