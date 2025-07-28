#!/bin/bash

if grep -q '^ZSH_THEME="rabby"' ~/.zshrc; then
    sed -i '/^ZSH_THEME="rabby"/d' ~/.zshrc
    sed -i 's/^#ZSH_THEME=/ZSH_THEME=/' ~/.zshrc
fi
