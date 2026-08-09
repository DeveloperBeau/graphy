# Benchmark runner for the crclite cipher.

. ./Ciphers/CrcLite/Cipher.ps1
. ./Ciphers/CrcLite/Keys.ps1

function Invoke-CrcLiteBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Get-CrcLiteDigest -Data $Sample
    }
    return $out.Length
}

function Get-CrcLiteBenchLabel {
    param([int] $Rounds = 16)
    return "crclite x$Rounds"
}
