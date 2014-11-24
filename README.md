
# ZSH

The default shell on most systems is bash. While bash is a perfectly fine shell, zsh is more customizable, faster (so they say) and has some amazing plugins. It does everything bash does and comes pre-installed on any Mac. It's an outdated version though, so you want to use homebrew to install the latest version.

```
brew install zsh
```

To change your shell on a OS X you can either run `chsh -s /usr/local/bin/zsh` or go to `System Preferences -> Users & Groups -> Click the lock -> Right click your user -> Advanced Options` and paste `/usr/local/bin/zsh` in the login shell field.

Zsh has seen wide adoption by developers looking to improve their interactive shell experience. Most developers may already have cultivated a bash profile and collected tab completions, aliases and functions that help get repetitive tasks done quick.

## oh-my-zsh

[oh-my-zsh](http://ohmyz.sh/) is a community-driven framework for managing your zsh configuration. Includes 120+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, macports, etc), over 120 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community.

This repo is forked from [@robbyrussell](https://github.com/robbyrussell/oh-my-zsh) where i have added custom themes and plugins. Feel free to clone either versions but i will explain later on in details the things i have added in this repo as i constantly follow the new features in the pull requests from the main repo and incorporate useful things in here.

### Installation 

oh-my-zsh requires a minimum 4.3.9 version of Zsh.
I recommend if you would like to copy my settings is to follow instructions in my main [configuration repo](http://github.com/ahmadassaf/Configurations). However, if you wish to have a stand-alone installation then you can follow these instructions:

### Automatic Installtion

- **curl**: `curl -L http://install.ohmyz.sh | sh`
- **wget**: `wget --no-check-certificate http://install.ohmyz.sh -O - | sh`

The default location is ~/.oh-my-zsh (hidden in your home directory).

You can change the install directory with the `ZSH` environment variable, either by running export `ZSH=/your/path` before installing, or by setting it before the end of the install pipeline like this:

`curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | ZSH=~/.dotfiles/zsh sh`

### Manual Installation

- Clone the repository" `git clone git://github.com/ahmadassaf/oh-my-zsh.git`
- Optionally, backup your existing ~/.zshrc file: `cp ~/.zshrc ~/.zshrc.backup`
- Copy or link the cloned repo into your home `ln -s oh-my-zsh ~/.oh-my-zsh`
- Create a new Zsh config file by copying or linking the Zsh template provided: `ln -s .zshrc ~/.zshrc`
- Set Zsh as your default shell: `chsh -s /bin/zsh`
- Start or restart Zsh by opening a new command-line window.

I am using both terminal and iTerm2. I have set up my terminal to use bash and my iTerm to be using zsh. You can configure iTerm to use zsh by:

- Go to `iTerm -> Preferences -> Profiles`
- Set the Command to: `/usr/local/bin/zsh`

## Using Plugins and Themes

### Plugins

Enable the plugins you want in your `~/.zshrc`. 
Take a look at the `plugins/`directory and the wiki to see what’s available). Example: `plugins=(git osx ruby)`

### Themes

Change the `ZSH_THEME` environment variable in `~/.zshrc`.
Take a look at the `themes/` directory and the wiki to see what comes bundled with oh-my-zsh or check the [screenshots gallery](http://zshthem.es/all)

## Your Custom scripts, aliases, and functions

If you want to override any of the default behaviors, just add a new file (ending in `.zsh`) in the `custom/` directory.

If you have many functions that go well together, you can put them as a `*.plugin.zsh` file in the `custom/plugins/` directory and then enable this plugin (see ‘Usage’ above).

If you would like to override the functionality of a plugin distributed with oh-my-zsh, create a plugin of the same name in the `custom/plugins/` directory and it will be loaded instead of the one in `plugins/`.

The main zsh profile is customized with the plugins and theme of my chose as well as some PATH values. You can always change whatever you want:

```
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded. i.e. theunraveler wedisagree kphoen gozilla soren
ZSH_THEME="cobalt3"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew brew-cask coffee cp django emacs gem git-flow heroku npm node osx pyenv python scala sublime tmux)

# User configuration

export PATH="/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/Home/bin:/Users/ahmadassaf/bin:/Users/ahmadassaf/.pyenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin:/Applications/MAMP/Library/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `ali

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.as`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias reload="source ~/.zshrc"

source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

```

A very useful alias that i have added is `reload` which will allow you to easily apply changes you made in your configuration.

### Updates

By default you will be prompted to check for upgrades. If you would like oh-my-zsh to automatically upgrade itself without prompting you, set the following in your `~/.zshrc`: `DISABLE_UPDATE_PROMPT=true`

To disable upgrades entirely, set the following in your `~/.zshrc`:
`DISABLE_AUTO_UPDATE=true`

To upgrade directly from the command-line, just run `upgrade_oh_my_zsh`

### Uninstalling

If you want to uninstall oh-my-zsh, just run `uninstall_oh_my_zsh` from the command-line and it’ll remove itself and revert you to bash (or your previous Zsh configuration).

## Changes from [Forked Repo](https://github.com/robbyrussell/oh-my-zsh)

Due to the fact that the original repo's maintenance is not active, i have decided to host a fork and integrate to it my additional files and also those mentioned in any pull request of the original repo that i find useful. so far the list is:

### Plugins

- `aliases.zsh` i have added a whole bunch of aliases that i have been using in bash as well. In fact, the `aliases` file is built automatically by concatenating several alias files configured in my [bash-it repo](http://github.com/ahmadassaf/bash-it).
- `ant.plugin.zsh` Improved ant completion [Pull Request Ref.](https://github.com/robbyrussell/oh-my-zsh/pull/3329) 
- `_brew` Remove deprecated brew commands, update core commands [Pull Request Ref.](https://github.com/robbyrussell/oh-my-zsh/pull/3303)
- `_docker` Add docker useful alias [Pull Request Ref.](https://github.com/robbyrussell/oh-my-zsh/pull/3289)
    + Create a new container
    + Run a command in an existing container
    + Log out from a docker registry server
    + Pause all processes within a container
    + Unpause a paused container
- `git.plugin.zsh` added `gdt` alias to launch git difftool
- `go.plugin.zsh` **[NEW]**

### Themes

- Added cobalt3 theme `cobalt3.zsh.theme` [screenshot below]
![zsh cobalt3 Theme](https://github.com/ahmadassaf/configurations/blob/master/screenshots/oh-my-zsh_theme_cobalt3.png)

# References

- [Z Shell](http://zsh.sourceforge.net/)
- [Zsh Reference Card](http://www.bash2zsh.com/zsh_refcard/refcard.pdf)
- [Badassify your terminal and shell](http://jilles.me/badassify-your-terminal-and-shell/)
- [My Extravagant Zsh Prompt](http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/)
- [My favorite Zsh features](http://code.joejag.com/2014/why-zsh.html)