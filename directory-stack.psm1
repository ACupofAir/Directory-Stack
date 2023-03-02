# init the module
$Script:dirs_stack = New-Object System.Collections.Generic.List[string]
$Script:static_dirs_stack = New-Object System.Collections.Generic.List[string]
$static_config_file = "~/.config/directory-stack/static_dir.cfg"
if (-not $(Test-Path ~/.config/directory-stack))
{
  New-Item ~/.config/directory-stack -ItemType "directory"
  New-Item $static_config_file
  Write-Output "Create ~/.config/directory-stack directory"
}
$static_dirs_stack_names = Get-Content $static_config_file
foreach ($static_item in $static_dirs_stack_names)
{
  $dirs_stack.Add($static_item)
  $static_dirs_stack.Add($static_item)
}

function Get-Dir-Stack
{
  if ($dirs_stack.Count -eq 0)
  {
    Write-Host "The stack is empty, use 'pd dir_name' to push the directory to the stack" -ForegroundColor red
  } else
  {
    Write-Host "Directory Stack:" -ForegroundColor green
    Write-Host "-------------------------------------------------------------" -ForegroundColor Yellow
    for ($i = 0; $i -le ($dirs_stack.Count -1); $i += 1)
    {
      Write-Host "  $i  " -NoNewline
      Write-Host "|  " -NoNewline -ForegroundColor Yellow
      Write-Host "$($dirs_stack[$i])"
    }
    Write-Host "-------------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "Select an index or press any key to exit: " -NoNewline -ForegroundColor Cyan
    [int]$input_idx = Read-Host
    if ($input_idx -is [ int ] -and $input_idx -lt $dirs_stack.Count)
    {
      Set-Location $dirs_stack[$input_idx]
      Write-Host "Jump to " -NoNewline
      Write-Host "$($dirs_stack[$input_idx])" -ForegroundColor Green
    }
  }
}

function Set-Dir-Stack($input_text)
{
  if ($null -eq $input_text)
  {
    # Put current directory into stack
    $current_dir = $(Get-Location)
    if ($current_dir -notin $dirs_stack)
    {
      $dirs_stack.Add($current_dir)
    } else
    {
      Write-Host "Current directory has been added in the stack" -ForegroundColor blue
    }
  } elseif ($input_text -is [ int ] -and $input_text -lt $dirs_stack.Count)
  {
    # Go to the directory in the stack whose index is the input_text
    Set-Location $dirs_stack[$input_text]
    Write-Host "Jump to " -NoNewline
    Write-Host "$($dirs_stack[$input_text])" -ForegroundColor Green
  } elseif ($input_text -is [ string ])
  {
    # Go to the directory of input, and put it in the stack
    Set-Location $input_text -ErrorAction stop
    $input_dir = $(Get-Location)
    if ($input_dir -notin $dirs_stack)
    {
      $dirs_stack.Add($input_dir)
    } else
    {
      Write-Host "Current directory has been added in the stack" -ForegroundColor blue
    }
  } else
  {
    # If the input_text is unavailable, print error info and show the current stack
    Write-Error("The directory stack length is $($dirs_stack.Count)")
    Get-Dir-Stack
  }
}

function Remove-Dir-Stack-Item([int]$index)
{
  if ($index -is [ int ] -and $index -lt $dirs_stack.Count)
  {
    $dirs_stack.RemoveAt($index)
  } else
  {
    Write-Error("The index $index must less than stack length $($dirs_stack.Count)")
  }
}

# The functions below are worked for static directories
function Show-Static-Dirs()
{
  Write-Host "Static Directories:" -ForegroundColor green
  Write-Host "-------------------------------------------------------------" -ForegroundColor Yellow
  for ($i = 0; $i -le ($static_dirs_stack.Count -1); $i += 1)
  {
    Write-Host "  $i  " -NoNewline
    Write-Host "|  " -NoNewline -ForegroundColor Yellow
    Write-Host "$($static_dirs_stack[$i])"
  }
  Write-Host "-------------------------------------------------------------" -ForegroundColor Yellow
}

function Add-Static-Dir-Item($item_name)
{
  if (Test-Path $item_name)
  {
    Out-File -FilePath $static_config_file -Append -InputObject $item_name
    Write-Host "Restart the terminal session to apply the changes" -ForegroundColor Red
  } else
  {
    Write-Error("The Path is unavailable")
  }
}

function Remove-Static-Dir-Item($input_idx)
{
  $static_dirs_stack.RemoveAt($input_idx)
  Out-File -FilePath $static_config_file -InputObject $static_dirs_stack
  Write-Host "Restart the terminal session to apply the changes" -ForegroundColor Red
}
