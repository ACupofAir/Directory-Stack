# Directory-Stack

A powershell module to switch directory quickly

## :gear: Install

- Install from PowerShell Gallery(Suggestion)
  - `Install-Module -Name directory-stack`
- Install mannual
  - download this repository: `git clone git@github.com:ACupofAir/Directory-Stack.git` and rename it to `directory-stack`
  - reference the folder in you powershell profile(`$PROFILE` is the default powershell config filek) , add this line to the profile
    `Import-Module -Name $repository_path -DisableNameChecking`

## :toolbox: Usage
![demo](https://github.com/ACupofAir/dotfiles/blob/main/res/dir_stack_demo.gif?raw=true)
- pushd directory in stack
  - `pd`: pushd current directory in the stack
  - `pd $DIR_NAME`: pushd $DIR_NAME in the stack
- popd directory out stack
  - `pp $DIR_INDEX`; popd directory index $DIR_INDEX in stack out
- show the directories in stack and switch to special stack
  - `dv`: show the table of stack, and waiting for user to input the index of directory want to go
  - `pd $DIR_INDEX`: jump to the directory whose index is $DIR_INDEX in the stack
