# Minimal CSV encoding for the results file.

function ConvertTo-CsvField {
    param([string] $Field)
    return '"' + $Field.Replace('"', '""') + '"'
}

function ConvertTo-CsvRow {
    param([string[]] $Fields)
    return ($Fields | ForEach-Object { ConvertTo-CsvField -Field $_ }) -join ","
}

function Get-CsvHeader {
    return ConvertTo-CsvRow -Fields @("cipher", "rounds", "bytes", "micros")
}
