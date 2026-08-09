# Benchmark runner for the rotblocks cipher.

. ./Ciphers/RotBlocks/Cipher.ps1
. ./Ciphers/RotBlocks/Keys.ps1

function Invoke-RotBlocksBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-RotBlocksEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-RotBlocksBenchLabel {
    param([int] $Rounds = 16)
    return "rotblocks x$Rounds"
}
