# Benchmark runner for the blockswap cipher.

. ./Ciphers/BlockSwap/Cipher.ps1
. ./Ciphers/BlockSwap/Keys.ps1

function Invoke-BlockSwapBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-BlockSwapEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-BlockSwapBenchLabel {
    param([int] $Rounds = 16)
    return "blockswap x$Rounds"
}
