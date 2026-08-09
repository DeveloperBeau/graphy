# Benchmark runner for the interleave cipher.

. ./Ciphers/Interleave/Cipher.ps1
. ./Ciphers/Interleave/Keys.ps1

function Invoke-InterleaveBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-InterleaveEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-InterleaveBenchLabel {
    param([int] $Rounds = 16)
    return "interleave x$Rounds"
}
