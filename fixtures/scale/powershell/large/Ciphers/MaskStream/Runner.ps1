# Benchmark runner for the maskstream cipher.

. ./Ciphers/MaskStream/Cipher.ps1
. ./Ciphers/MaskStream/Keys.ps1

function Invoke-MaskStreamBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-MaskStreamEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-MaskStreamBenchLabel {
    param([int] $Rounds = 16)
    return "maskstream x$Rounds"
}
