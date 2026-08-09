# Benchmark runner for the shift5 cipher.

. ./Ciphers/Shift5/Cipher.ps1
. ./Ciphers/Shift5/Keys.ps1

function Invoke-Shift5Bench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-Shift5Encrypt -Data $Sample
    }
    return $out.Length
}

function Get-Shift5BenchLabel {
    param([int] $Rounds = 16)
    return "shift5 x$Rounds"
}
