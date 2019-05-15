#!/bin/bash

path_join () {
    local IFS="$1"; shift; echo "$*"
}

path_parts () {
    local paths=($(cat "$@" 2> /dev/null)); path_join : "${paths[@]}"
}

path_helper () {
    echo "PATH=\"$(path_parts /etc/paths /etc/paths.d/*)\"; export PATH;"
}
