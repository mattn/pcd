$env:PCD_CONFIG = "$env:UserProfile\.pcd"

Function usage {
  echo "[add PATH | edit]"
  exit
}
Function edit {
  if ("$env:EDITOR" -ne "") {
    & "$env:EDITOR" "$env:PCD_CONFIG"
    exit
  } else {
    & notepad "$env:PCD_CONFIG"
    exit
  }
}
Function query {
# If you have a problem caused by character-set, modify below part like:
# ... | iconv -f char -t utf-8 ^| peco --null'
  ForEach ($line in $($(type "$env:PCD_CONFIG" | peco) -split "`r`n")) {
    cd $line
    break
  }
}

if ($args[0] -eq "add") {
  if ($args[1]) {
    usage
  } else {
    $(get-location).Path >> "$env:PCD_CONFIG"
    exit
  }
}
if ($args[0] -eq "edit") {
  if ($args[1]) {
    usage
  } else {
    edit
  }
}
if ($args[0]) {
  usage
} else {
  query
}
