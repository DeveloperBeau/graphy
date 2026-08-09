# Benchmark runner for the rot47 cipher.

. ./Ciphers/Rot47/Cipher.ps1
. ./Ciphers/Rot47/Keys.ps1

function Invoke-Rot47Bench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-Rot47Encrypt -Data $Sample
    }
    return $out.Length
}

function Get-Rot47BenchLabel {
    param([int] $Rounds = 16)
    return "rot47 x$Rounds"
}
