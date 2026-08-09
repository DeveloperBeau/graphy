# Benchmark runner for the keymix cipher.

. ./Ciphers/Keymix/Cipher.ps1
. ./Ciphers/Keymix/Keys.ps1

function Invoke-KeymixBench {
    param(
        [byte[]] $Sample,
        [int] $Rounds = 16
    )
    $out = $null
    for ($r = 0; $r -lt $Rounds; $r++) {
        $out = Invoke-KeymixEncrypt -Data $Sample
    }
    return $out.Length
}

function Get-KeymixBenchLabel {
    param([int] $Rounds = 16)
    return "keymix x$Rounds"
}
