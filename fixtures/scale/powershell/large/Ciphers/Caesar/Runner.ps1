# Benchmark runner for the caesar cipher.

. ./Ciphers/Caesar/Cipher.ps1
. ./Ciphers/Caesar/Keys.ps1

function Invoke-CaesarBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-CaesarEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-CaesarBenchLabel {
    param([int] $Rounds = 16)
    return "caesar x$Rounds"
}
