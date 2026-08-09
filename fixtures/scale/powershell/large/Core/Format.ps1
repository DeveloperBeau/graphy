# Human-readable units.

function Format-ByteCount {
    param([long] $Bytes)
    if ($Bytes -ge 1MB) {
        return "{0}MiB" -f [long]($Bytes / 1MB)
    }
    if ($Bytes -ge 1KB) {
        return "{0}KiB" -f [long]($Bytes / 1KB)
    }
    return "${Bytes}B"
}

function Format-Micros {
    param([long] $Micros)
    if ($Micros -ge 1000000) {
        return "{0}s" -f [long]($Micros / 1000000)
    }
    return "${Micros}us"
}
