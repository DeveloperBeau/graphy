# Final one-screen digest after a full run.

function Format-SummaryRow {
    param(
        [string] $Name,
        [string] $Bytes,
        [string] $Time
    )
    return "{0,-14} {1,10} {2,10}" -f $Name, $Bytes, $Time
}

function Show-BenchSummary {
    Write-Host "ciphers run: $(Get-RegisteredCount)"
    Write-Host (Format-SummaryRow -Name "cipher" -Bytes "bytes" -Time "time")
    Write-Host (Format-SummaryRow -Name "------" -Bytes "-----" -Time "----")
}
