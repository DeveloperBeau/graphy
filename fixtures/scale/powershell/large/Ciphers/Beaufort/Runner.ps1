# Benchmark runner for the beaufort cipher.

. ./Ciphers/Beaufort/Cipher.ps1
. ./Ciphers/Beaufort/Keys.ps1

function Invoke-BeaufortBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-BeaufortEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-BeaufortBenchLabel {
    param([int] $Rounds = 16)
    return "beaufort x$Rounds"
}
