# Benchmark runner for the quagmire cipher.

. ./Ciphers/Quagmire/Cipher.ps1
. ./Ciphers/Quagmire/Keys.ps1

function Invoke-QuagmireBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-QuagmireEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-QuagmireBenchLabel {
    param([int] $Rounds = 16)
    return "quagmire x$Rounds"
}
