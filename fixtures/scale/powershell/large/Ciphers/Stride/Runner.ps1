# Benchmark runner for the stride cipher.

. ./Ciphers/Stride/Cipher.ps1
. ./Ciphers/Stride/Keys.ps1

function Invoke-StrideBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-StrideEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-StrideBenchLabel {
    param([int] $Rounds = 16)
    return "stride x$Rounds"
}
