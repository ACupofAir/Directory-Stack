# Directory-Stack

A powershell module to switch directory quickly

## :gear: Install

- Powershell Gallery: `cmd todo`

## :toolbox: Usage

- pushd directory in stack
  - `pd`: pushd current directory in the stack
  - `pd $DIR_NAME`: pushd $DIR_NAME in the stack
- popd directory out stack
  - `pp $DIR_INDEX`; popd directory index $DIR_INDEX in stack out
- show the directories in stack and switch to special stack
  - `dv`: show the table of stack, and waiting for user to input the index of directory want to go
  - `pd $DIR_INDEX`: jump to the directory whose index is $DIR_INDEX in the stack
