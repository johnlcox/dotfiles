#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Check if `jenv` is installed

    if ! cmd_exists "jenv"; then
        print_error "Jenv is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Java 6" "java6" "homebrew/versions" "cask"

    brew_install "Oracle Java Latest" "java"

    brew_install "Java 9 Beta" "java9-beta" "homebrew/versions" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add Installed Java versions to jenv

    jenv add /Library/Java/JavaVirtualMachines/*/Contents/Home

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

}

main
