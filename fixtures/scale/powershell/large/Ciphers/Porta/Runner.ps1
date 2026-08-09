# Benchmark runner for the porta cipher.

. ./Ciphers/Porta/Cipher.ps1
. ./Ciphers/Porta/Keys.ps1

function Invoke-PortaBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-PortaEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-PortaBenchLabel {
    param([int] $Rounds = 16)
    return "porta x$Rounds"
}
