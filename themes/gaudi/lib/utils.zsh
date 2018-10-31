#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# UTILS
# Utils for common used actions
# ------------------------------------------------------------------------------

# Check if command exists in $PATH
# USAGE:
#   gaudi::exists <command>
gaudi::exists() {
  command -v $1 > /dev/null 2>&1
}

# Check if function is defined
# USAGE:
#   gaudi::defined <function>
gaudi::defined() {
  type -t "$1" &> /dev/null
}

# contains(string, substring)
#
# Returns 0 if the specified string contains the specified substring,
# otherwise returns 1.
gaudi::contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

# Draw prompt section
# USAGE:
#   gaudi::section <color> [prefix] [symbol] <content> [suffix]
gaudi::section() {
    
    local color prefix symbol content suffix
    
    [[ -n $1 ]] && color="$1"    || color=""
    [[ -n $2 ]] && prefix="$2"   || prefix=""
    [[ -n $3 ]] && symbol="$3"   || symbol=""
    [[ -n $4 ]] && content="$4"  || content=""
    [[ -n $5 ]] && suffix="$5"   || suffix=""
    
    # gaudi::escape "$color$prefix$symbol $content$suffix${NC}"
    # printf "%b%b%b %b%b%b" "$color" "$prefix" "$symbol" "$content" "$suffix" "${NC}"

    [[ $GAUDI_ENABLE_SYMBOLS == false ]] && symbol="$GAUDI_SYMBOL_ALT " || symbol="$symbol "
    # Why are wrapping the cariables with "" you say ?
    # To pass a whole string containing whitespaces as a single argument, enclose it in double quotes
    # Like every other program, echo -n or printf interprets strings separated by whitespace as different arguments
    echo -n "$color"    # Print out any coloring needed for the section with order of <font_color><background_color>
    echo -n "$prefix"   # Print the prefix before the content .. default prefix is a space 
    echo -n "$symbol"   # Print the symbol if exists which is the icon to show before the segment
    echo -n "$content"  # Print the actual content to display in the prompt
    echo -n "$suffix"   # Print the suffix before the content .. default prefix is a space 
    echo -n "$NC"       # Reset the coloring set in the $color
}

# Render a prompt section by getting the segments from the segments definitions array
# USAGE:
#   gaudi::render_prompt segments <array>
gaudi::render_prompt() {
  
  # Option EXTENDED_GLOB is set locally to force filename generation on
  # argument to conditions, i.e. allow usage of explicit glob qualifier (#q).
  # See the description of filename generation in
  # http://zsh.sourceforge.net/Doc/Release/Conditional-Expressions.html
  setopt EXTENDED_GLOB LOCAL_OPTIONS SHWORDSPLIT

  local _prompt=""
  declare -a _segments=("${(P)1}")
  
  if [[ -n "${_segments}" ]]; then
    for segment in $_segments; do
      source "$GAUDI_ROOT/segments/$segment.zsh"
      export GAUDI_SYMBOL_ALT=$segment
      local info="$(gaudi_$segment)"
      [[ -n "${info}" ]] && _prompt+="$info"
    done
    echo -n $_prompt
    unset GAUDI_SYMBOL_ALT
  fi;
}

# Display seconds in human readable fromat
# Based on http://stackoverflow.com/a/32164707/3859566
# USAGE:
#   spaceship::displaytime <seconds>
gaudi::displaytime() {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%dd ' $D
  [[ $H > 0 ]] && printf '%dh ' $H
  [[ $M > 0 ]] && printf '%dm ' $M
  printf '%ds' $S
}
