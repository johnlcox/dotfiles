#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install() {

    declare -r CMD="$4"
    declare -r FORMULA="$2"
    declare -r FORMULA_READABLE_NAME="$1"
    declare -r TAP_VALUE="$3"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Homebrew` is installed

    if ! cmd_exists "brew"; then
        print_error "$FORMULA_READABLE_NAME (\`brew\` is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If `brew tap` needs to be executed, check if it executed correctly

    if [ -n "$TAP_VALUE" ]; then
        if ! brew_tap "$TAP_VALUE"; then
            print_error "$FORMULA_READABLE_NAME (\`brew tap $TAP_VALUE\` failed)"
            return 1
        fi
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specified formula

    if brew "$CMD" list "$FORMULA" &> /dev/null; then
        print_success "$FORMULA_READABLE_NAME"
    else
        execute "brew $CMD install $FORMULA" "$FORMULA_READABLE_NAME"
    fi

}

brew_tap() {
    brew tap "$1" &> /dev/null
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

mas_install() {

    declare -r CMD="$4"
    declare -r APP_ID="$2"
    declare -r APP_READABLE_NAME="$1"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `mas-cli` is installed

    if ! cmd_exists "mas"; then
        print_error "$APP_READABLE_NAME (\`mas\` is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specified app

    if mas "$CMD" list "$APP_ID" &> /dev/null; then
        print_success "$APP_READABLE_NAME"
    else
        execute "mas $CMD install $APP_ID" "$APP_READABLE_NAME"
    fi

}
