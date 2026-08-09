# Live progress reporting during a run.

$script:ProgressTotal = 0
$script:ProgressDone = 0

function Start-BenchProgress {
    param([int] $Total)
    $script:ProgressTotal = $Total
    $script:ProgressDone = 0
}

function Update-BenchProgress {
    param([string] $Activity)
    $script:ProgressDone++
    $percent = [int](100 * $script:ProgressDone / $script:ProgressTotal)
    Write-Progress -Activity $Activity -PercentComplete $percent
}

function Complete-BenchProgress {
    Write-Progress -Activity "done" -Completed
}
