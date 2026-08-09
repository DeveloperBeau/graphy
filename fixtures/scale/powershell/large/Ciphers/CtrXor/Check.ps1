# Round-trip verification for the ctrxor cipher.

. ./Ciphers/CtrXor/Cipher.ps1

function Test-CtrXorRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-CtrXorEncrypt -Data $Sample
    $decrypted = Invoke-CtrXorDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-CtrXorCheckLabel {
    return "verify:ctrxor"
}
