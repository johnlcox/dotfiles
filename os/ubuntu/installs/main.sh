#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare OS_ARCH="$(get_os_arch)"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    update
    upgrade

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Tools for compiling/building software from source
    install_package "Build Essential" "build-essential"

    # GnuPG archive keys of the Debian archive
    install_package "GnuPG archive keys" "debian-archive-keyring"

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons
    #install_package "Ubuntu Restricted Extras" "ubuntu-restricted-extras"

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "atom"; then

        add_ppa "webupd8team/atom" \
            || print_error "Atom (add PPA)"

        update &> /dev/null \
            || print_error "Atom (resync package index files)"

    fi

    install_package "Atom" "atom"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "google-chrome"; then

        add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
            || print_error "Chrome Canary (add key)"

        add_to_source_list "[arch=amd64] https://dl.google.com/linux/deb/ stable main" "google-chrome.list" \
            || print_error "Chrome Canary (add to package resource list)"

        update &> /dev/null \
            || print_error "Chrome Canary (resync package index files)"

    fi

    install_package "Chrome Canary" "google-chrome-stable"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "vim" "vim"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "cURL" "curl"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Flash" "flashplugin-installer"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "GIMP" "gimp"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Git" "git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "tmux" "tmux"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "xclip" "xclip"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "dconf-cli" "dconf-cli"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Install/Update jenv"

    ask_for_confirmation "Do you want to install/update jenv?"
    printf "\n"

    if answer_is_yes; then
        ./../../install_jenv.sh
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./jdk.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./install_solarized_gnome_theme.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # TODO: Maven

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Add Gnome terminal active tab highlighting

    cat << EOF > ~/.config/gtk-3.0/gtk.css
    TerminalWindow .notebook tab:active {
        background-color: #b0c0f0;
    }
    EOF

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_green "\n  ---\n\n"
    update
    upgrade

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_green "\n  ---\n\n"
    autoremove

}

main
