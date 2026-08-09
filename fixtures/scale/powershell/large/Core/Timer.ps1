# Microsecond wall-clock timing via the stopwatch API.

function Get-BenchStopwatch {
    return [System.Diagnostics.Stopwatch]::StartNew()
}

function Measure-BenchElapsed {
    param($Stopwatch)
    $Stopwatch.Stop()
    return [long]($Stopwatch.Elapsed.TotalMilliseconds * 1000)
}
