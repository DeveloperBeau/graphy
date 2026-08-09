# Benchmark runner for the sdbm cipher.

. ./Ciphers/Sdbm/Cipher.ps1
. ./Ciphers/Sdbm/Keys.ps1

function Invoke-SdbmBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Get-SdbmDigest -Data $Sample
    }
    return $out.Length
}

function Get-SdbmBenchLabel {
    param([int] $Rounds = 16)
    return "sdbm x$Rounds"
}
