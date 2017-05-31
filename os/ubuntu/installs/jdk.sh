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

    if ! package_is_installed "oracle-java9-installer"; then
      add_ppa "webupd8team/java" \
          || print_error "Oracle Java (add PPA)"

      update &> /dev/null \
          || print_error "Oracle Java (resync package index files)"
    fi

    install_package "Oracle JDK9" "oracle-java9-installer"
    install_package "oracle-java9-set-default"

    if ! package_is_installed "oracle-java9-installer"; then
      add_ppa "webupd8team/java" \
          || print_error "Oracle Java (add PPA)"

      update &> /dev/null \
          || print_error "Oracle Java (resync package index files)"
    fi

    install_package "Oracle JDK8" "oracle-java8-installer"

    ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add Installed Java versions to jenv

    jenv add /usr/lib/jvm/*

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

}

main
