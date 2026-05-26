#!/usr/bin/env bash
# feature: function (POSIX form), function (keyword form)
format_name() {
    local name="$1"
    echo "hi, $name"
}

function unrelated_helper {
    echo 7
}
