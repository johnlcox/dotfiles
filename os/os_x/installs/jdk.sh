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

    brew_install "Java 6" "java6" "caskroom/versions" "cask"

    brew_install "Oracle Java Latest" "java" "homebrew/versions" "cask"

    brew_install "Java 9 Beta" "java9-beta" "caskroom/versions" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add Installed Java versions to jenv

    for path in /Library/Java/JavaVirtualMachines/*; do
        [ -d "${path}" ] || continue # if not a directory, skip
        jenv add /Library/Java/JavaVirtualMachines/$(basename "${path}")/Contents/Home
    done

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

}

main
