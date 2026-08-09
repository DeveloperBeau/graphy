# Benchmark runner for the xorshift cipher.

. ./Ciphers/XorShift/Cipher.ps1
. ./Ciphers/XorShift/Keys.ps1

function Invoke-XorShiftBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-XorShiftEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-XorShiftBenchLabel {
    param([int] $Rounds = 16)
    return "xorshift x$Rounds"
}
