#!/usr/bin/bash

if [! -d "$HOME/bin" ]; then
    mkdir $HOME/bin
fi

curl https://raw.githubusercontent.com/ACupofAir/Directory-Stack/main/bash/dir_stack.sh > $HOME/bin/dir_stack.sh

if [ -f "~/.bashrc" ]; then
    echo "PATH="$HOME/bin:$PATH" >> ~/.bashrc
    echo "source $HOME/bin/dir_stack.sh" >> ~/.bashrc
    source ~/.bashrc
elif [ -f "~/.zshrc" ]; then
    echo "PATH="$HOME/bin:$PATH" >> ~/.zshrc
    echo "source $HOME/bin/dir_stack.sh" >> ~/.zshrc
    source ~/.zshrc