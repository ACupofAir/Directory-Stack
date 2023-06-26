# init, create the file to store dir stack if is not exist
$Script:dirs_stack = New-Object System.Collections.Generic.List[string]
$static_config_file = "~/.config/directory-stack/static_dir.cfg"
if (-not $(Test-Path ~/.config/directory-stack)) {
  New-Item ~/.config/directory-stack -ItemType "directory"
  New-Item $static_config_file
  Write-Output "Create ~/.config/directory-stack directory"
}

# get the items in dir stack and offer an easy way to jump by idx
function Get-Dir-Stack {
  # from now, the dir stack is all static
  $static_dirs_stack_names = Get-Content $static_config_file
  $dirs_stack.Clear()
  foreach ($static_item in $static_dirs_stack_names) {
    $dirs_stack.Add($static_item)
  }
  if ($dirs_stack.Count -eq 0) {
    Write-Host "The stack is empty, use 'pd dir_name' to push the directory to the stack" -ForegroundColor red
  }
  else {
    Write-Host "Directory Stack:" -ForegroundColor green
    Write-Host "-------------------------------------------------------------" -ForegroundColor Yellow
    for ($i = 0; $i -le ($dirs_stack.Count - 1); $i += 1) {
      Write-Host "  $i  " -NoNewline
      Write-Host "|  " -NoNewline -ForegroundColor Yellow
      Write-Host "$($dirs_stack[$i])"
    }
    Write-Host "-------------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "Select an index or press ENTER to exit: " -NoNewline -ForegroundColor Cyan
    $input_idx = Read-Host
    if ($input_idx.Length -gt 0) {
      $input_idx = [int]$input_idx
    }
    if ($input_idx -is [ int ]) {
      if ( $input_idx -lt $dirs_stack.Count) {
        Set-Location $dirs_stack[$input_idx]
        Write-Host "Jump to " -NoNewline
        Write-Host "$($dirs_stack[$input_idx])" -ForegroundColor Green
      }
      else {
        Write-Error("Index out of range! The directory stack index must less than $($dirs_stack.Count - 1)")
      }
    }
  }
}

# add item to dir stack
function Add-Dir-Item($input_text) {
  if ($null -eq $input_text) {
    # Put current directory into stack
    $current_dir = $(Get-Location).path
    if ($current_dir -notin $dirs_stack) {
      $dirs_stack.Add($current_dir)
      Out-File -FilePath $static_config_file -Append -InputObject $current_dir
      Write-Host "Add " -NoNewline
      Write-Host "$current_dir " -NoNewline -ForegroundColor Green
      Write-Host "to directory stack" 
    }
  }
  elseif ($input_text -is [ string ]) {
    # Go to the directory of input, and put it in the stack
    Set-Location $input_text -ErrorAction stop
    $input_dir = $(Get-Location).path
    if ($input_dir -notin $dirs_stack) {
      $dirs_stack.Add($input_dir)
      Out-File -FilePath $static_config_file -Append -InputObject $input_dir
      Write-Host "Add " -NoNewline
      Write-Host "$input_dir " -NoNewline -ForegroundColor Green
      Write-Host "to directory stack" 
    }
    else {
      Write-Host "Add the same directory repeatedly!" -ForegroundColor blue
    }
  }
  else {
    Write-Error("Invalid input, expecting string or none")
  }
}

# jump to stack by idx
function Set-Stacked-Dir($input_text) {
  if ($input_text -is [ int ] -and $input_text -lt $dirs_stack.Count) {
    # Go to the directory in the stack whose index is the input_text
    Set-Location $dirs_stack[$input_text]
    Write-Host "Jump to " -NoNewline
    Write-Host "$($dirs_stack[$input_text])" -ForegroundColor Green
  }
  else {
    # If the input_text is unavailable, print error info and show the current stack
    Write-Error("The directory stack length is $($dirs_stack.Count)")
    Get-Dir-Stack
  }
}

function Remove-Dir-Stack-Item([int]$index) {
  if ($index -is [ int ] -and $index -lt $dirs_stack.Count) {
    Write-Host "Remove " -NoNewline
    Write-Host "$($dirs_stack[$index]) " -NoNewline -ForegroundColor Red
    Write-Host "from directory stack" 
    $dirs_stack.RemoveAt($index)
    Out-File -FilePath $static_config_file -InputObject $dirs_stack
  }
  else {
    Write-Error("The index $index must less than stack length $($dirs_stack.Count)")
  }
}