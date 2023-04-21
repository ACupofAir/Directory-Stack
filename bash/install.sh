#!/usr/bin/bash

if [ ! -d "$HOME/bin" ]; then
    mkdir $HOME/bin
fi

dirs_stack_config_folder=~/.config/dirs_stack/
dirs_stack_file=~/.config/dirs_stack/store_arr

if [ ! -d ${dirs_stack_config_folder} ]; then
    mkdir -p ${dirs_stack_config_folder}
    echo "create directory ${dirs_stack_config_folder}"
fi

if [ ! -f ${dirs_stack_file} ]; then
    touch ${dirs_stack_file}
    echo "create file ${dirs_stack_file}"
fi

curl https://raw.githubusercontent.com/ACupofAir/Directory-Stack/main/bash/dir_stack.sh > $HOME/bin/dir_stack.sh

if [ -f "$HOME/.bashrc" ]; then
    echo "PATH=$HOME/bin:$PATH" >> ~/.bashrc
    echo "source $HOME/bin/dir_stack.sh" >> ~/.bashrc
    source $HOME/.bashrc
fi

if [ -f "$HOME/.zshrc" ]; then
    echo "PATH=$HOME/bin:$PATH" >> ~/.zshrc
    echo "source $HOME/bin/dir_stack.sh" >> ~/.zshrc
    source $HOME/.zshrc
fi

echo "successfully installed"