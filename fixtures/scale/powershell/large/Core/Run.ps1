# Full-run orchestration over every registered cipher.

function Invoke-BenchOne {
    param(
        [string] $Name,
        [byte[]] $Sample
    )
    $watch = Get-BenchStopwatch
    $rounds = Get-BenchOption -Name "Rounds"
    $length = & "Invoke-${Name}Bench" -Sample $Sample -Rounds $rounds
    $micros = Measure-BenchElapsed -Stopwatch $watch
    Add-ResultRow -Row (ConvertTo-CsvRow -Fields @($Name, "$rounds", "$length", "$micros"))
    Update-BenchProgress -Activity $Name
}

function Invoke-BenchAll {
    $sample = Get-CorpusSample -Length (Get-BenchOption -Name "SampleSize")
    Initialize-ResultStore
    Add-ResultRow -Row (Get-CsvHeader)
    Start-BenchProgress -Total (Get-RegisteredCount)
    foreach ($name in Get-RegisteredCiphers) {
        Invoke-BenchOne -Name $name -Sample $sample
    }
    Complete-BenchProgress
    Show-BenchSummary
}

function Test-AllCiphers {
    $sample = Get-CorpusSample -Length 64
    foreach ($name in Get-RegisteredCiphers) {
        if (-not (& "Test-${Name}RoundTrip" -Sample $sample)) {
            Write-BenchWarn -Message "verify failed: $name"
        }
    }
}
