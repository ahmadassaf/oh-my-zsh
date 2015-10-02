# List directory contents
alias sl=ls
# List all files colorized in long format
alias ll="ls -lF --color"
# List all files colorized in long format, including dot files
alias la="ls -laF --color"
# List only directories
alias lsd="ls -lF --color | grep --color=never '^d'"
# Always use color output for `ls`
alias ls="command ls --color"
alias l='ls -a'
alias l1='ls -1'
alias llt="ls -lFt --color"
alias count="ls -1 | wc -l"

alias _="sudo"
# Enable aliases to be sudo’ed
alias sudo='sudo '
# Get week number
alias week='date +%V'

alias c='clear'
alias cls='clear'

alias edit="$EDITOR"
alias pager="$PAGER"
alias q='exit'
alias irc="$IRC_CLIENT"
alias rb='ruby'
alias screenshot='webkit2png'

# Pianobar can be found here: http://github.com/PromyLOPh/pianobar/
alias piano='pianobar'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Shell History
alias h='history'

# Rapid access to OVH server
alias ovh='ssh 149.202.53.241'

# Tree
if [ ! -x "$(which tree 2>/dev/null)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# Directory
alias	md='mkdir -p'
alias	rd='rmdir'

which gshuf &> /dev/null
if [ $? -eq 0 ]
then
  alias shuf=gshuf
fi
# Shortcuts
alias d="cd ~/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"
alias doc="cd ~/Documents"
alias dev="cd ~/Developer"
alias app="cd /Applications"
alias g="git"
alias gpu="git pull upstream"
alias gpu2="git push upstream"
alias gpg="git pull github"
alias gpg2="git push github"
alias h="history"
alias j="jobs"
alias o="open"
alias oo="open ."
alias htdocs="cd /Applications/MAMP/htdocs/"
alias mysql="mysql --host localhost"
alias mongod="mongod --dbpath ~/Applications/mongodb/data/db/"
alias protege="sh /Applications/Protege\ 5.0/run.sh"

# Control Plex Media Server
alias startPlex="sudo launchctl load /Library/LaunchDaemons/com.plex.plexconnect.bash.plist"
alias stopPlex="sudo launchctl unload /Library/LaunchDaemons/com.plex.plexconnect.bash.plist"
alias checkPlex="sudo launchctl list | grep plexconnect"

# OSX Yosemite Specific
alias flushdns="sudo discoveryutil mdnsflushcache;sudo discoveryutil udnsflushcaches;say flushed"

# Switch between Node and IO.js
alias usenode='brew unlink iojs && brew link node && echo Using Node.js'
alias useio='brew unlink node && brew link --force iojs && echo Using io.js'