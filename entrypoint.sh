#!/usr/bin/env bash

set -e

valid_tasks=("tell-the-cow" "reverse-names")

array_contains() {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ $element == $seeking ]]; then
            in=0
            break
        fi
    done
    return $in
}

help() {
    cat <<EOF

Usage: trivial-docker-example [-h] [${valid_tasks[@]}] [\$ARGS]

Accepts one mandatory positional argument to choose the task to run

Positional task argument (case sensitive):
    command    ${valid_tasks[@]}

Additional arguments are dependent on the command. Run the command with a [--help] argument for more info.

EOF
}

while getopts "h?:" opt; do
    case "$opt" in
    h | \?)
        help
        exit 0
        ;;
    esac
done

shift $((OPTIND - 1))

# This syntax is absurd: https://refine.dev/blog/bash-script-arguments/#implementing-flags-and-options
[ "${1:-}" = "--" ] && shift

task=$1
shift
args="$@"
echo "performing [$task] with arguments ["$args"]"

if [[ !$(array_contains valid_tasks $task) ]]; then
    $task "$args"
else
    echo "$task is not a valid task"
    help
fi
