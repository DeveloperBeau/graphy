# Benchmark runner for the revblocks cipher.

. ./Ciphers/RevBlocks/Cipher.ps1
. ./Ciphers/RevBlocks/Keys.ps1

function Invoke-RevBlocksBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-RevBlocksEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-RevBlocksBenchLabel {
    param([int] $Rounds = 16)
    return "revblocks x$Rounds"
}
