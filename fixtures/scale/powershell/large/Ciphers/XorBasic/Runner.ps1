# Benchmark runner for the xorbasic cipher.

. ./Ciphers/XorBasic/Cipher.ps1
. ./Ciphers/XorBasic/Keys.ps1

function Invoke-XorBasicBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-XorBasicEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-XorBasicBenchLabel {
    param([int] $Rounds = 16)
    return "xorbasic x$Rounds"
}
