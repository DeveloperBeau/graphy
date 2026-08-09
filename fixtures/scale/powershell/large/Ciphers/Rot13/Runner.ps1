# Benchmark runner for the rot13 cipher.

. ./Ciphers/Rot13/Cipher.ps1
. ./Ciphers/Rot13/Keys.ps1

function Invoke-Rot13Bench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-Rot13Encrypt -Data $Sample
    }
    return $out.Length
}

function Get-Rot13BenchLabel {
    param([int] $Rounds = 16)
    return "rot13 x$Rounds"
}
