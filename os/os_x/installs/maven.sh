#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Check if `Homebrew` is installed

    if ! cmd_exists "brew"; then
        print_error "Homebrew is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Maven 3.2" "maven32"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}

main
