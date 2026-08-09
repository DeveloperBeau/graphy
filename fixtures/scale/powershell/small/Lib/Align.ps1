# Horizontal alignment within a fixed width.

function Format-PadLeft {
    param(
        [string] $Text,
        [int] $Width
    )
    return $Text.PadLeft($Width)
}

function Format-PadRight {
    param(
        [string] $Text,
        [int] $Width
    )
    return $Text.PadRight($Width)
}

function Format-Centered {
    param(
        [string] $Text,
        [int] $Width
    )
    $lead = [int](($Width - $Text.Length) / 2) + $Text.Length
    return (Format-PadLeft -Text $Text -Width $lead)
}
