
## Functions

bundle_install() {
  if ! _bundler-installed; then
    echo "Bundler is not installed"
  elif ! _within-bundled-project; then
    echo "Can't 'bundle install' outside a bundled project"
  else
    local bundler_version=`bundle version | cut -d' ' -f3`
    if [[ $bundler_version > '1.4.0' || $bundler_version = '1.4.0' ]]; then
      if [[ "$OSTYPE" = (darwin|freebsd)* ]]
      then
        local cores_num="$(sysctl -n hw.ncpu)"
      else
        local cores_num="$(nproc)"
      fi
      bundle install --jobs=$cores_num $@
    else
      bundle install $@
    fi
  fi
}

_bundler-installed() {
  which bundle > /dev/null 2>&1
}

_within-bundled-project() {
  local check_dir="$PWD"
  while [ "$check_dir" != "/" ]; do
    [ -f "$check_dir/Gemfile" ] && return
    check_dir="$(dirname $check_dir)"
  done
  false
}

_binstubbed() {
  [ -f "./bin/${1}" ]
}

_run-with-bundler() {
  if _bundler-installed && _within-bundled-project; then
    if _binstubbed $1; then
      ./bin/$@
    else
      bundle exec $@
    fi
  else
    $@
  fi
}