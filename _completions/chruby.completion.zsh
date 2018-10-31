# complete on installed rubies
_chruby() {
    compadd $(chruby | tr -d '* ')
    local default_path='/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
    if PATH=${default_path} type ruby &> /dev/null; then
        compadd system
    fi
}
compdef _chruby chruby