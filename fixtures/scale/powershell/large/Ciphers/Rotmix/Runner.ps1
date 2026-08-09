# Benchmark runner for the rotmix cipher.

. ./Ciphers/Rotmix/Cipher.ps1
. ./Ciphers/Rotmix/Keys.ps1

function Invoke-RotmixBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-RotmixEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-RotmixBenchLabel {
    param([int] $Rounds = 16)
    return "rotmix x$Rounds"
}
