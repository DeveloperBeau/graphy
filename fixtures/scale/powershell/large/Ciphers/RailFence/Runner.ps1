# Benchmark runner for the railfence cipher.

. ./Ciphers/RailFence/Cipher.ps1
. ./Ciphers/RailFence/Keys.ps1

function Invoke-RailFenceBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-RailFenceEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-RailFenceBenchLabel {
    param([int] $Rounds = 16)
    return "railfence x$Rounds"
}
