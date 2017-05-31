#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh" \
    && source "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    declare -r OHMYZSH_DIRECTORY="$HOME/.oh-my-zsh"

    ./install_xcode.sh

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./install_homebrew.sh
    brew_install "Homebrew Cask" "caskroom/cask/brew-cask" "caskroom/cask"

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Bash" "bash"
    brew_install "Bash Completion 2" "bash-completion2" "homebrew/versions"
    ./change_default_bash_version.sh

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Atom" "atom" "caskroom/cask" "cask"
    brew_install "Chrome" "google-chrome" "caskroom/cask" "cask"
    brew_install "Firefox" "firefox" "caskroom/cask" "cask"
    brew_install "Flash" "flash" "caskroom/cask" "cask"
    brew_install "BetterTouchTool" "bettertouchtool" "caskroom/cask" "cask"
    brew_install "Karabiner" "karabiner" "caskroom/cask" "cask"
    brew_install "RightZoom" "rightzoom" "caskroom/cask" "cask"
    #brew_install "GIMP" "lisanet-gimp" "caskroom/cask" "cask"
    brew_install "Git" "git"
    brew_install "tmux" "tmux"
    brew_install "Vim" "vim --override-system-vi"
    brew_install "Zsh" "zsh"
    brew_install "Zsh Completions" "zsh-completions"

    if [ ! -d "$OHMYZSH_DIRECTORY" ]; then

        curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

    fi


    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Install/Update jenv"

    ask_for_confirmation "Do you want to install/update jenv?"
    printf "\n"

    if answer_is_yes; then
        ./../../install_jenv.sh
    fi

    ./jdk.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./maven.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew install gradle

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./update_and_upgrade.sh
    ./cleanup.sh

}

main
