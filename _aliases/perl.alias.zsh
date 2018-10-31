# Aliases ###################################################################

# perlbrew ########
alias pbi='perlbrew install'
alias pbl='perlbrew list'
alias pbo='perlbrew off'
alias pbs='perlbrew switch'
alias pbu='perlbrew use'

# Perl ############

# perldoc`
alias pd='perldoc'

# use perl like awk/sed
alias ple='perl -wlne'

# show the latest stable release of Perl
alias latest-perl='curl -s https://www.perl.org/get.html | perl -wlne '\''if (/perl\-([\d\.]+)\.tar\.gz/) { print $1; exit;}'\'