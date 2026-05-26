#!/usr/bin/env bash
# feature: source, dot-source, function, call
source helpers.sh
. types.sh

run_service() {
    local name="$1"
    local greeting
    greeting=$(format_name "$name")
    echo "$greeting"
}

describe_service() {
    local name="$1"
    echo "Service($name)"
}
