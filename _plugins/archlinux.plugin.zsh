function paclist() {
  # Source: https://bbs.archlinux.org/viewtopic.php?id=93683
  LC_ALL=C pacman -Qei $(pacman -Qu | cut -d " " -f 1) | \
    awk 'BEGIN {FS=":"} /^Name/{printf("\033[1;36m%s\033[1;37m", $2)} /^Description/{print $2}'
}

function pacdisowned() {
  emulate -L zsh

  tmp=${TMPDIR-/tmp}/pacman-disowned-$UID-$$
  db=$tmp/db
  fs=$tmp/fs

  mkdir "$tmp"
  trap  'rm -rf "$tmp"' EXIT

  pacman -Qlq | sort -u > "$db"

  find /bin /etc /lib /sbin /usr ! -name lost+found \
    \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

  comm -23 "$fs" "$db"
}

function pacmanallkeys() {
  emulate -L zsh
  curl -s https://www.archlinux.org/people/{developers,trustedusers}/ | \
    awk -F\" '(/pgp.mit.edu/) { sub(/.*search=0x/,""); print $1}' | \
    xargs sudo pacman-key --recv-keys
}

function pacmansignkeys() {
  emulate -L zsh
  for key in $*; do
    sudo pacman-key --recv-keys $key
    sudo pacman-key --lsign-key $key
    printf 'trust\n3\n' | sudo gpg --homedir /etc/pacman.d/gnupg \
      --no-permission-warning --command-fd 0 --edit-key $key
  done
}

if (( $+commands[xdg-open] )); then
  function pacweb() {
    pkg="$1"
    infos="$(pacman -Si "$pkg")"
    if [[ -z "$infos" ]]; then
      return
    fi
    repo="$(grep '^Repo' <<< "$infos" | grep -oP '[^ ]+$')"
    arch="$(grep '^Arch' <<< "$infos" | grep -oP '[^ ]+$')"
    xdg-open "https://www.archlinux.org/packages/$repo/$arch/$pkg/" &>/dev/null
  }
fi
