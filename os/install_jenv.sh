!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "utils.sh"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r JENV_DIRECTORY="$HOME/.jenv"
    declare -r JENV_GIT_REPO_URL="https://github.com/gcuisinier/jenv.git"

    declare -r CONFIGS='
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# jenv

export PATH="$HOME/.jenv/bin:$PATH"

eval "$(jenv init -)"

'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Git` is installed

    if ! cmd_exists "git"; then
        print_error "Git is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install / Update jenv

    if [ ! -d "$JENV_DIRECTORY" ]; then

        git clone "$JENV_GIT_REPO_URL" "$JENV_DIRECTORY" &> /dev/null
        print_result $? "jenv"

        if [ $? -eq 0 ]; then
            printf "%s" "$CONFIGS" >> "$HOME/.zsh.local" \
                && source "$HOME/.zsh.local"
            print_result $? "jenv (update ~/.zsh.local)"
        fi

    fi

    if [ -d "$JENV_DIRECTORY" ]; then

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Ensure the latest version of `nvm` is used

        cd "$JENV_DIRECTORY" \
            && git checkout `git describe --abbrev=0 --tags` &> /dev/null
        print_result $? "jenv (update)"

        eval "$(jenv init -)"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Install the specified `node` versions

        for i in ${NODE_VERSIONS[@]}; do
            execute "nvm install $i" "nvm (install: $i)"
        done

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # By default, use the latest stable version of `node`

        execute "nvm alias default node" "nvm (set default)"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    fi

}

main
