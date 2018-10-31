bundled_commands=(
  annotate
  cap
  capify
  cucumber
  foodcritic
  guard
  hanami
  irb
  jekyll
  kitchen
  knife
  middleman
  nanoc
  pry
  puma
  rackup
  rainbows
  rake
  rspec
  shotgun
  sidekiq
  spec
  spork
  spring
  strainer
  tailor
  taps
  thin
  thor
  unicorn
  unicorn_rails
)

# Remove $UNBUNDLED_COMMANDS from the bundled_commands list
for cmd in $UNBUNDLED_COMMANDS; do
  bundled_commands=(${bundled_commands#$cmd});
done

# Add $BUNDLED_COMMANDS to the bundled_commands list
for cmd in $BUNDLED_COMMANDS; do
  bundled_commands+=($cmd);
done


## Main program
for cmd in $bundled_commands; do
  eval "function unbundled_$cmd () { $cmd \$@ }"
  eval "function bundled_$cmd () { _run-with-bundler $cmd \$@}"
  alias $cmd=bundled_$cmd

  if which _$cmd > /dev/null 2>&1; then
    compdef _$cmd bundled_$cmd=$cmd
  fi
done