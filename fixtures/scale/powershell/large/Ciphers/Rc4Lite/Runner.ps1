# Benchmark runner for the rc4lite cipher.

. ./Ciphers/Rc4Lite/Cipher.ps1
. ./Ciphers/Rc4Lite/Keys.ps1

function Invoke-Rc4LiteBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-Rc4LiteEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-Rc4LiteBenchLabel {
    param([int] $Rounds = 16)
    return "rc4lite x$Rounds"
}
