#!/usr/bin/env zsh

GAUDI_FIRST_RUN=${GAUDI_FIRST_RUN:=true}
GAUDI_ROOT="${ZSH}/themes/gaudi"

source "$GAUDI_ROOT/gaudi.configs.zsh"
source "$GAUDI_ROOT/lib/utils.zsh"
source "$GAUDI_ROOT/lib/colors.zsh"
source "$GAUDI_ROOT/lib/scm.zsh"
source "$GAUDI_ROOT/lib/hooks.zsh"

# Do not load if not an interactive shell
# Reference: https://github.com/nojhan/liquidprompt/issues/161
test -z "$TERM" -o "x$TERM" = xdumb && return

gaudi::prompt() {
  RETVAL=$?
  # Should it add a new line before the prompt?
  [[ $GAUDI_PROMPT_ADD_NEWLINE == true ]] && echo ""
  
  gaudi::render_prompt GAUDI_PROMPT_LEFT
  echo -n "$GAUDI_NEW_LINE$(gaudi_char)"
}

gaudi::right_prompt() {
  gaudi::render_prompt GAUDI_PROMPT_RIGHT  
}

# Runs once when user opens a terminal
# All preparation before drawing prompt should be done here
gaudi::setup() {
  
  # This variable is a magic variable used when loading themes with zsh's prompt
  # function. It will ensure the proper prompt options are set.
  prompt_opts=(cr percent sp subst)

  # Borrowed from promptinit, sets the prompt options in case the prompt was not
  # initialized via promptinit.
  setopt noprompt{bang,cr,percent,subst} "prompt${^prompt_opts[@]}"

  # Prevent percentage showing up if output doesn't end with a newline.
	export PROMPT_EOL_MARK=''

  autoload -Uz add-zsh-hook
  autoload -Uz async
  autoload -U colors && colors

  # Source the prompt char configuration
  source "$GAUDI_ROOT/segments/char.zsh"

  PROMPT='$(gaudi::prompt)'
  RPROMPT='$(gaudi::right_prompt)'

  # Load the PS2 continuation bash configuration
  source "$GAUDI_ROOT/segments/continuation.zsh"
  
  # PS2 – Continuation interactive prompt
  PS2='$(gaudi_continuation)'

	# Store prompt expansion symbols for in-place expansion via (%). For
	# some reason it does not work without storing them in a variable first.
	typeset -ga prompt_gaudi_debug_depth
	prompt_gaudi_debug_depth=('%e' '%N' '%x')

  # Compare is used to check if %N equals %x. When they differ, the main
	# prompt is used to allow displaying both file name and function. When
	# they match, we use the secondary prompt to avoid displaying duplicate
	# information.
	local -A ps4_parts
	ps4_parts=(
		depth 	  '%F{yellow}${(l:${(%)prompt_gaudi_debug_depth[1]}::+:)}%f'
		compare   '${${(%)prompt_gaudi_debug_depth[2]}:#${(%)prompt_gaudi_debug_depth[3]}}'
		main      '%F{blue}${${(%)prompt_gaudi_debug_depth[3]}:t}%f%F{242}:%I%f %F{242}@%f%F{blue}%N%f%F{242}:%i%f'
		secondary '%F{blue}%N%f%F{242}:%i'
		prompt 	  '%F{242}>%f '
	)
	# Combine the parts with conditional logic. First the `:+` operator is
	# used to replace `compare` either with `main` or an ampty string. Then
	# the `:-` operator is used so that if `compare` becomes an empty
	# string, it is replaced with `secondary`.
	local ps4_symbols='${${'${ps4_parts[compare]}':+"'${ps4_parts[main]}'"}:-"'${ps4_parts[secondary]}'"}'

	# Improve the debug prompt (PS4), show depth by repeating the +-sign and
	# add colors to highlight essential parts like file and function name.
	PROMPT4="${ps4_parts[depth]} ${ps4_symbols}${ps4_parts[prompt]}"
}

# Pass all arguments to the spaceship_setup function
gaudi::setup "$@"