# Post-run report over the stored results.

function Format-ReportLine {
    param([string] $Row)
    return "  " + $Row.Replace('","', "  ").Trim('"')
}

function Show-BenchReport {
    $path = Get-ResultPath
    if (-not (Test-Path $path)) {
        Write-BenchWarn -Message "no results at $path"
        return
    }
    Write-Host "results from ${path}:"
    Get-Content -Path $path | ForEach-Object {
        Write-Host (Format-ReportLine -Row $_)
    }
}
