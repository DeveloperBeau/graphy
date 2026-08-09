# Round-trip verification for the blockswap cipher.

. ./Ciphers/BlockSwap/Cipher.ps1

function Test-BlockSwapRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-BlockSwapEncrypt -Data $Sample
    $decrypted = Invoke-BlockSwapDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-BlockSwapCheckLabel {
    return "verify:blockswap"
}
