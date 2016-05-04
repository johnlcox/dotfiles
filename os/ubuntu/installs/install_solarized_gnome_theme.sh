#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    local -r SOLARIZED_GNOME_GIT_REPO_URL="https://github.com/johnlcox/gnome-terminal-colors-solarized.git"
    local -r SOLARIZED_GNOME_TEMP_DIR="gnome-terminal-colors-solarized"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Git` is installed

    if ! cmd_exists "git"; then
        print_error "Git is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install / Update vim plugins

    rm -rf "$SOLARIZED_GNOME_TEMP_DIR" &> /dev/null \
        && git clone "$VUNDLE_GIT_REPO_URL" "$SOLARIZED_GNOME_TEMP_DIR" &> /dev/null \
        && printf "\n" 2> /dev/null \
        && "$SOLARIZED_GNOME_TEMP_DIR"/install.sh
        #     └─ simulate the ENTER keypress for
        #        the case where there are warnings
    print_result $? "Install Solarized Gnome Terminal theme"
}

main
