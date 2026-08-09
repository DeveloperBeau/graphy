# Benchmark runner for the vigenere cipher.

. ./Ciphers/Vigenere/Cipher.ps1
. ./Ciphers/Vigenere/Keys.ps1

function Invoke-VigenereBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-VigenereEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-VigenereBenchLabel {
    param([int] $Rounds = 16)
    return "vigenere x$Rounds"
}
