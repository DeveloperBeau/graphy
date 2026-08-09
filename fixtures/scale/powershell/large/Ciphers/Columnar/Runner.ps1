# Benchmark runner for the columnar cipher.

. ./Ciphers/Columnar/Cipher.ps1
. ./Ciphers/Columnar/Keys.ps1

function Invoke-ColumnarBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-ColumnarEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-ColumnarBenchLabel {
    param([int] $Rounds = 16)
    return "columnar x$Rounds"
}
