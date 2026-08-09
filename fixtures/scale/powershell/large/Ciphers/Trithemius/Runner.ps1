# Benchmark runner for the trithemius cipher.

. ./Ciphers/Trithemius/Cipher.ps1
. ./Ciphers/Trithemius/Keys.ps1

function Invoke-TrithemiusBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-TrithemiusEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-TrithemiusBenchLabel {
    param([int] $Rounds = 16)
    return "trithemius x$Rounds"
}
