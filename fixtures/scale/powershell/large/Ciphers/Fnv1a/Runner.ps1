# Benchmark runner for the fnv1a cipher.

. ./Ciphers/Fnv1a/Cipher.ps1
. ./Ciphers/Fnv1a/Keys.ps1

function Invoke-Fnv1aBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Get-Fnv1aDigest -Data $Sample
    }
    return $out.Length
}

function Get-Fnv1aBenchLabel {
    param([int] $Rounds = 16)
    return "fnv1a x$Rounds"
}
