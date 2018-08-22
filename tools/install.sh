# Use colors, but only if connected to a terminal, and that terminal supports them

if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then

    # Reset
    export NC="\033[0m"       # Text Reset

    # Regular Colors
    export BLACK="\033[0;30m"        # Black
    export RED="\033[0;31m"          # Red
    export GREEN="\033[0;32m"        # Green
    export YELLOW="\033[0;33m"       # Yellow
    export BLUE="\033[0;34m"         # Blue
    export MAGENTA="\033[0;35m"      # magenta
    export CYAN="\033[0;36m"         # Cyan
    export WHITE="\033[0;37m"        # White

else

    export NC=""
    export BLACK=""
    export RED=""
    export GREEN=""
    export YELLOW=""
    export BLUE=""
    export MAGENTA=""
    export CYAN=""
    export WHITE=""

fi

main() {

  printf "\n

   ▄██████▄     ▄█    █▄           ▄▄▄▄███▄▄▄▄   ▄██   ▄         ▄███████▄     ▄████████    ▄█    █▄    
███    ███   ███    ███        ▄██▀▀▀███▀▀▀██▄ ███   ██▄      ██▀     ▄██   ███    ███   ███    ███   
███    ███   ███    ███        ███   ███   ███ ███▄▄▄███            ▄███▀   ███    █▀    ███    ███   
███    ███  ▄███▄▄▄▄███▄▄      ███   ███   ███ ▀▀▀▀▀▀███       ▀█▀▄███▀▄▄   ███         ▄███▄▄▄▄███▄▄ 
███    ███ ▀▀███▀▀▀▀███▀       ███   ███   ███ ▄██   ███        ▄███▀   ▀ ▀███████████ ▀▀███▀▀▀▀███▀  
███    ███   ███    ███        ███   ███   ███ ███   ███      ▄███▀                ███   ███    ███   
███    ███   ███    ███        ███   ███   ███ ███   ███      ███▄     ▄█    ▄█    ███   ███    ███   
 ▀██████▀    ███    █▀          ▀█   ███   █▀   ▀█████▀        ▀████████▀  ▄████████▀    ███    █▀    
                                                                                                      
\n
"
  if ! command -v zsh >/dev/null 2>&1; then
    printf "${YELLOW}Zsh is not installed!${NC} Please install zsh first!\n"
    exit
  fi

  if [ ! -n "$ZSH" ]; then
    ZSH=~/.oh-my-zsh
  fi

  if [ -d "$ZSH" ]; then
    printf "${YELLOW}You already have Oh My Zsh installed.${NC}\n"
    printf "You'll need to remove $ZSH if you want to re-install.\n"
    exit
  fi

  # Prevent the cloned repository from having insecure permissions. Failing to do
  # so causes compinit() calls to fail with "command not found: compdef" errors
  # for users with insecure umasks (e.g., "002", allowing group writability). Note
  # that this will be ignored under Cygwin by default, as Windows ACLs take
  # precedence over umasks except for filesystems mounted with option "noacl".
  umask g-w,o-w

  printf "${BLUE}Cloning Oh My Zsh...${NC}\n"
  command -v git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  # The Windows (MSYS) Git is not compatible with normal use on cygwin
  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi
  env git clone --depth=1 https://github.com/ahmadassaf/oh-my-zsh.git "$ZSH" || {
    printf "Error: git clone of oh-my-zsh repo failed\n"
    exit 1
  }


  printf "${BLUE}Looking for an existing zsh config...${NC}\n"
  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    printf "${YELLOW}Found ~/.zshrc.${NC} ${GREEN}Backing up to ~/.zshrc.pre-oh-my-zsh${NC}\n";
    mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
  fi

  printf "${BLUE}Using the Oh My Zsh template file and adding it to ~/.zshrc${NC}\n"
  cp "$ZSH"/templates/zshrc.zsh-template ~/.zshrc
  sed "/^export ZSH=/ c\\
  export ZSH=\"$ZSH\"
  " ~/.zshrc > ~/.zshrc-omztemp
  mv -f ~/.zshrc-omztemp ~/.zshrc

  echo ""
  read -p "$(echo "${RED}Would you like to change your shell to Zsh${NC}") [Y/N] " -n 1 CHANGE_SHELL </dev/tty
  if [[ $CHANGE_SHELL =~ ^[yY]$ ]]; then
    echo "⚡  Changing shell to zsh"
    # If this user's login shell is not already "zsh", attempt to switch.
    TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
    if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
      # If this platform provides a "chsh" command (not Cygwin), do it, man!
      if hash chsh >/dev/null 2>&1; then
        printf "${BLUE}Time to change your default shell to zsh!${NC}\n"
        chsh -s $(grep /zsh$ /etc/shells | tail -1)
      # Else, suggest the user do so manually.
      else
        printf "I can't change your shell automatically because this system does not have chsh.\n"
        printf "${BLUE}Please manually change your default shell to zsh!${NC}\n"
      fi
    fi
  fi

  printf "\n${BLUE}oh-my-zsh is now installed ... Please look over the ~/.zshrc file to select plugins, themes, and options${NC}\n\n"
}

main
