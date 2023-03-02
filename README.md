# Directory-Stack

A powershell module to switch directory quickly

## :gear: Install

- Install from PowerShell Gallery(Suggestion)
  - `Install-Module -Name directory-stack`
- Update from PowerShell Gallery(Suggestion)
  - `Update-Module -Name directory-stack`
- Install mannual
  - download this repository: `git clone git@github.com:ACupofAir/Directory-Stack.git` and rename it to `directory-stack`
  - reference the folder in you powershell profile(`$PROFILE` is the default powershell config filek) , add this line to the profile
    `Import-Module -Name $repository_path -DisableNameChecking`
- Optional Config: set alias of the function names in your `$PROFILE` to use them easily

  ```powershell
  # in $PROFILE(usually is "~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1")
  Set-Alias -Name dv Get-Dir-Stack
  Set-Alias -Name pd Set-Dir-Stack
  Set-Alias -Name pp Remove-Dir-Stack-Item
  ```

## :toolbox: Usage

> **Following usage will run rightly after config alias in $PROFILE**

![demo](https://github.com/ACupofAir/dotfiles/blob/main/res/dir_stack_demo.gif?raw=true)

- pushd directory in stack
  - `pd`: pushd current directory in the stack
  - `pd $DIR_NAME`: pushd `$DIR_NAME` in the stack
- popd directory out stack
  - `pp $DIR_INDEX`; popd directory index `$DIR_INDEX` in stack out
- show the directories in stack and switch to special stack
  - `dv`: show the table of stack(named from the linux command dirs -v), and waiting for user to input the index of directory want to go
  - `pd $DIR_INDEX`: jump to the directory whose index is `$DIR_INDEX` in the stack
- `Add-Static-Dir-Item $DIR_NAME`: add one directory will autoload in directory stack
- `Show-Static-Dirs`: show the directory items which will autoload into directory stack
- `Remove-Static-Dir-Item $DIR_INDEX`: remove one directory in static directory stack

## :date: Release Log

| version | release date | description                    |
| ------- | ------------ | ------------------------------ |
| v1.1.0  | 2023/02/03   | add autoload directory support |
