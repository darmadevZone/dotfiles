#!/bin/bash

set -ue

helpmsg() {
    command echo "Usage: $0 [--help| -]" 0>&2
    command echo ""
}

link_to_homedir() {
    command echo "backup old dotfiles..."
    if [! -d "$HOME/.dotfiles"]; then
        command echo "$HOME/.dotbackup not found. Auto Make it"
        command mkdir "$HOME/.dotbackup"
    fi
}

#Install Brew
if [! -f /opt/homebrew]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#Install fish and change default shell
if ["$(dscl . -read ~/ UserShell)" = "UserShell: /bin/bash"]; then
    brew install fish
    chsh -s /opt/homebrew/bin/fish
fi

DOT_CONFIG_PATH=~/.config
if [! -d "$DOT_CONFIG_PATH"]; then
    git clone git@github.com:darmadevZone/dotfiles.git
fi

brew bundle -v --file ./Brewfile
