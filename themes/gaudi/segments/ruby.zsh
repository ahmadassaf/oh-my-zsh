#!/usr/bin/env zsh
#
# Ruby
#
# A dynamic, reflective, object-oriented, general-purpose programming language.
# Link: https://www.ruby-lang.org/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

GAUDI_RUBY_SHOW="${GAUDI_RUBY_SHOW=true}"
GAUDI_RUBY_PREFIX="${GAUDI_RUBY_PREFIX="$GAUDI_PROMPT_DEFAULT_PREFIX"}"
GAUDI_RUBY_SUFFIX="${GAUDI_RUBY_SUFFIX="$GAUDI_PROMPT_DEFAULT_SUFFIX"}"
GAUDI_RUBY_SYMBOL="${GAUDI_RUBY_SYMBOL="\\uf43b "}"
GAUDI_RUBY_COLOR="${GAUDI_RUBY_COLOR="$RED"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of Ruby
gaudi_ruby() {
  
  setopt null_glob

  [[ $GAUDI_RUBY_SHOW == false ]] && return

  # Show versions only for Ruby-specific folders
  [[ -f Gemfile || -f Rakefile || -n $(find . -not -path '*/\.*' -maxdepth 1 -name "*.rb") ]] || return

  local 'ruby_version'

  if gaudi::exists rvm-prompt; then
    ruby_version="$(rvm-prompt i v g)"
  elif gaudi::exists chruby; then
    ruby_version="$(chruby | sed -n -e 's/ \* //p')"
  elif gaudi::exists rbenv; then
    ruby_version="$(rbenv version-name)"
  else
    ruby_version=$(ruby --version | awk '{print $2}' | tr "p" " " | awk '{print $1}')
  fi

  [[ -z $ruby_version || "${ruby_version}" == "system" ]] && return

  # Add 'v' before ruby version that starts with a number
  [[ "${ruby_version}" =~ ^[0-9].+$ ]] && ruby_version="v${ruby_version}"

  gaudi::section \
    "$GAUDI_RUBY_COLOR" \
    "$GAUDI_RUBY_PREFIX" \
    "$GAUDI_RUBY_SYMBOL" \
    "$ruby_version" \
    "$GAUDI_RUBY_SUFFIX"
}
