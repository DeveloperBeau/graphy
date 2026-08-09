# Benchmark runner for the addmod cipher.

. ./Ciphers/Addmod/Cipher.ps1
. ./Ciphers/Addmod/Keys.ps1

function Invoke-AddmodBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-AddmodEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-AddmodBenchLabel {
    param([int] $Rounds = 16)
    return "addmod x$Rounds"
}
