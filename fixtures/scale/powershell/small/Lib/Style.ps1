# Text emphasis via ANSI escape codes.

function Format-Bold {
    param([string] $Text)
    return "$([char]27)[1m$Text$([char]27)[0m"
}

function Format-Underline {
    param([string] $Text)
    return "$([char]27)[4m$Text$([char]27)[0m"
}

function Format-Styled {
    param(
        [string] $Style,
        [string] $Text
    )
    switch ($Style) {
        "bold" { Format-Bold -Text $Text }
        "underline" { Format-Underline -Text $Text }
        default { $Text }
    }
}
