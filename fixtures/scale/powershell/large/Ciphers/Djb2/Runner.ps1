# Benchmark runner for the djb2 cipher.

. ./Ciphers/Djb2/Cipher.ps1
. ./Ciphers/Djb2/Keys.ps1

function Invoke-Djb2Bench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Get-Djb2Digest -Data $Sample
    }
    return $out.Length
}

function Get-Djb2BenchLabel {
    param([int] $Rounds = 16)
    return "djb2 x$Rounds"
}
