#!/bin/bash

cd "$(dirname "$BASH_SOURCE")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -a PROCESSES_TO_TERMINATE=(
        "cfprefsd"
    )

    ./set_language_and_region_preferences.sh
    ./set_photos_preferences.sh

    for i in ${PROCESSES_TO_TERMINATE[*]}; do
        killall "$i" &> /dev/null
    done

}

main
