# Round-trip verification for the columnar cipher.

. ./Ciphers/Columnar/Cipher.ps1

function Test-ColumnarRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-ColumnarEncrypt -Data $Sample
    $decrypted = Invoke-ColumnarDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-ColumnarCheckLabel {
    return "verify:columnar"
}
