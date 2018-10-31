

# Aliases ###################################################################
# These are for more obscure uses of apt-get and aptitude that aren't covered
# below.
alias age='apt-get'
alias api='aptitude'

# Some self-explanatory aliases
alias acs="apt-cache search"
alias aps='aptitude search'
alias as="aptitude -F \"* %p -> %d \n(%v/%V)\" \
		--no-gui --disable-columns search"	# search package

# apt-file
alias afs='apt-file search --regexp'


# These are apt-get only
alias asrc='apt-get source'
alias app='apt-cache policy'

# superuser operations ######################################################
if [[ $use_sudo -eq 1 ]]; then
# commands using sudo #######
    alias aac='sudo $apt_pref autoclean'
    alias abd='sudo $apt_pref build-dep'
    alias ac='sudo $apt_pref clean'
    alias ad='sudo $apt_pref update'
    alias adg='sudo $apt_pref update && sudo $apt_pref $apt_upgr'
    alias adu='sudo $apt_pref update && sudo $apt_pref dist-upgrade'
    alias afu='sudo apt-file update'
    alias au='sudo $apt_pref $apt_upgr'
    alias ai='sudo $apt_pref install'
    # Install all packages given on the command line while using only the first word of each line:
    # acs ... | ail
    alias ail="sed -e 's/  */ /g' -e 's/ *//' | cut -s -d ' ' -f 1 | "' xargs sudo $apt_pref install'
    alias ap='sudo $apt_pref purge'
    alias ar='sudo $apt_pref remove'

    # apt-get only
    alias ads='sudo apt-get dselect-upgrade'

    # Install all .deb files in the current directory.
    # Warning: you will need to put the glob in single quotes if you use:
    # glob_subst
    alias dia='sudo dpkg -i ./*.deb'
    alias di='sudo dpkg -i'

    # Remove ALL kernel images and headers EXCEPT the one in use
    alias kclean='sudo aptitude remove -P ?and(~i~nlinux-(ima|hea) \
        ?not(~n`uname -r`))'


# commands using su #########
else
    alias aac='su -ls \'$apt_pref autoclean\' root'
    abd() {
        cmd="su -lc '$apt_pref build-dep $@' root"
        print "$cmd"
        eval "$cmd"
    }
    alias ac='su -ls \'$apt_pref clean\' root'
    alias ad='su -lc \'$apt_pref update\' root'
    alias adg='su -lc \'$apt_pref update && aptitude $apt_upgr\' root'
    alias adu='su -lc \'$apt_pref update && aptitude dist-upgrade\' root'
    alias afu='su -lc "apt-file update"'
    alias ag='su -lc \'$apt_pref $apt_upgr\' root'
    ai() {
        cmd="su -lc 'aptitude -P install $@' root"
        print "$cmd"
        eval "$cmd"
    }
    ap() {
        cmd="su -lc '$apt_pref -P purge $@' root"
        print "$cmd"
        eval "$cmd"
    }
    ar() {
        cmd="su -lc '$apt_pref -P remove $@' root"
        print "$cmd"
        eval "$cmd"
    }

    # Install all .deb files in the current directory
    # Assumes glob_subst is off
    alias dia='su -lc "dpkg -i ./*.deb" root'
    alias di='su -lc "dpkg -i" root'

    # Remove ALL kernel images and headers EXCEPT the one in use
    alias kclean='su -lc '\''aptitude remove -P ?and(~i~nlinux-(ima|hea) \
        ?not(~n`uname -r`))'\'' root'
fi

# Misc. #####################################################################
# print all installed packages
alias allpkgs='aptitude search -F "%p" --disable-columns ~i'

# Create a basic .deb package
alias mydeb='time dpkg-buildpackage -rfakeroot -us -uc'