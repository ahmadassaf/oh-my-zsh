cpv() {
    rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress "$@"
}
compdef _files cpv


# Copies the contents of a given file to the system or X Windows clipboard
#
# copyfile <file>
function copyfile {
  emulate -L zsh
  clipcopy $1
}


# Copies the pathname of the current directory to the system or X Windows clipboard
function copydir {
  emulate -L zsh
  print -n $PWD | clipcopy
}

# copy the active line from the command line buffer 
# onto the system clipboard (requires clipcopy plugin)

copybuffer () {
  if which clipcopy &>/dev/null; then
    echo $BUFFER | clipcopy
  else
    echo "clipcopy function not found. Please make sure you have Oh My Zsh installed correctly."
  fi
}

zle -N copybuffer

bindkey "^O" copybuffer
