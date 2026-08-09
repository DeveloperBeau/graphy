# Benchmark runner for the affine cipher.

. ./Ciphers/Affine/Cipher.ps1
. ./Ciphers/Affine/Keys.ps1

function Invoke-AffineBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-AffineEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-AffineBenchLabel {
    param([int] $Rounds = 16)
    return "affine x$Rounds"
}
