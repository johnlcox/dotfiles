#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "utils.sh"

declare -r LOCAL_SHELL_CONFIG_FILE="$HOME/.zsh.local"
declare -r RVM_DIRECTORY="$HOME/.rvm"
declare -r -a RUBY_VERSIONS=(
    "ruby"
    "2.1"
    "2.3"
)
# declare -r NVM_GIT_REPO_URL="https://github.com/creationix/nvm.git"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_rvm_configs() {

    declare -r CONFIGS='
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ruby Version Manager

export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute \
        "printf '%s' '$CONFIGS' >> $LOCAL_SHELL_CONFIG_FILE \
            && . $LOCAL_SHELL_CONFIG_FILE" \
        "rvm (update $LOCAL_SHELL_CONFIG_FILE)"

}

install_ruby_versions() {

    # Install the latest stable version of Ruby
    # (this will also set it as the default).

    for i in ${RUBY_VERSIONS[@]}; do
        execute \
            "rvm install $i" \
            "rvm (install $i)"
    done
}

install_rvm() {

    # Install `rvm` and add the necessary
    # configs in the local shell config file.

    execute \
        "curl -sSL https://get.rvm.io" \
        "rvm (install)"

}

# update_rvm() {
#
#     execute \
#         "curl -sSL https://get.rvm.io" \
#               #  └─ simulate the ENTER keypress
#         "rvm (upgrade)"
#
# }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   rvm\n\n"

    if [ ! -d "$RVM_DIRECTORY" ]; then
        install_rvm
        add_rvm_configs
    else
        install_rvm
    fi

    install_ruby_versions

}

main
