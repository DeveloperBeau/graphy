# Benchmark runner for the scytale cipher.

. ./Ciphers/Scytale/Cipher.ps1
. ./Ciphers/Scytale/Keys.ps1

function Invoke-ScytaleBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-ScytaleEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-ScytaleBenchLabel {
    param([int] $Rounds = 16)
    return "scytale x$Rounds"
}
