# Fixed-width line wrapping.

function Split-LongLine {
    param(
        [string] $Line,
        [int] $Width
    )
    $chunks = @()
    while ($Line.Length -gt $Width) {
        $chunks += $Line.Substring(0, $Width)
        $Line = $Line.Substring($Width)
    }
    $chunks += $Line
    return $chunks
}

function Format-Wrapped {
    param(
        [string[]] $Lines,
        [int] $Width
    )
    return $Lines | ForEach-Object { Split-LongLine -Line $_ -Width $Width }
}
