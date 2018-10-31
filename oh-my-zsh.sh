ZSH_COMPONENTS=(
  "plugin" "_plugins"
  "alias" "_aliases"
  "completion" "_completions"
)
# Set ZSH_CACHE_DIR to the path where cache files should be created
# or else we will use the default cache/
if [[ -z "$ZSH_CACHE_DIR" ]]; then
  ZSH_CACHE_DIR="$ZSH/cache"
fi

# Migrate .zsh-update file to $ZSH_CACHE_DIR
if [ -f ~/.zsh-update ] && [ ! -f ${ZSH_CACHE_DIR}/.zsh-update ]; then
    mv ~/.zsh-update ${ZSH_CACHE_DIR}/.zsh-update
fi

# Check for updates on initial load...
if [ "$DISABLE_AUTO_UPDATE" != "true" ]; then
  env ZSH=$ZSH ZSH_CACHE_DIR=$ZSH_CACHE_DIR DISABLE_UPDATE_PROMPT=$DISABLE_UPDATE_PROMPT zsh -f $ZSH/tools/check_for_upgrade.sh
fi

# Initializes Oh My Zsh

# add a function path
fpath=($ZSH/functions $ZSH/completions $fpath)

# Load all stock functions (from $fpath files) called below.
autoload -U compaudit compinit

# Figure out the SHORT hostname
if [[ "$OSTYPE" = darwin* ]]; then
  # macOS's $HOST changes with dhcp, etc. Use ComputerName if possible.
  SHORT_HOST=$(scutil --get ComputerName 2>/dev/null) || SHORT_HOST=${HOST/.*/}
else
  SHORT_HOST=${HOST/.*/}
fi

# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

if [[ $ZSH_DISABLE_COMPFIX != true ]]; then
  # If completion insecurities exist, warn the user
  if ! compaudit &>/dev/null; then
    handle_completion_insecurities
  fi
  # Load only from secure directories
  compinit -i -d "${ZSH_COMPDUMP}"
else
  # If the user wants it, load from all found directories
  compinit -u -d "${ZSH_COMPDUMP}"
fi

# Load all of the plugins that were defined in ~/.zshrc
for componentName componentPath in ${(kv)ZSH_COMPONENTS}; do
  for _component (${(P)componentPath}); do
    # We need now to check if we need to run any pre hooks
    # -L to force searching through symlinks just in case
    find -L $ZSH -type f -iname `echo "$_component.$componentName.zsh"` | while read _zshComponent; do
      source $_zshComponent
    done
  done
done

source "$ZSH/lib/termsupport.zsh"
# source "$ZSH/themes/gaudi/gaudi.theme.zsh"