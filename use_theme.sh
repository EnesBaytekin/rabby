#!/bin/bash

cp rabby.zsh-theme ~/.oh-my-zsh/themes/rabby.zsh-theme
if [ -f ~/.oh-my-zsh/themes/rabby.zsh-theme ]; then
    current_theme=$(grep '^ZSH_THEME=' ~/.zshrc | cut -d '"' -f 2)
    if [ "$current_theme" != "rabby" ]; then
        sed -i '/^ZSH_THEME=/ s/^/#/' ~/.zshrc
        sed -i '/^#ZSH_THEME=/a ZSH_THEME="rabby"' ~/.zshrc
    fi
fi
