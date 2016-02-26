# RBEnv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export RUBY_GC_HEAP_FREE_SLOTS=600000
export RUBY_GC_HEAP_GROWTH_FACTOR=1.25
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000
export RUBY_GC_HEAP_INIT_SLOTS=600000
export RUBY_GC_MALLOC_LIMIT=64000000
export RUBY_GC_OLDMALLOC_LIMIT=64000000
export RUBYOPT=rubygems

[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

## Auto-completion
sources=(`brew --prefix`/etc/bash_completion
         `brew --prefix git`/etc/bash_completion.d/git-completion.bash
         `brew --prefix git`/etc/bash_completion.d/git-prompt.sh
         `brew --prefix`/Library/Contributions/brew_bash_completion.sh)
for src in ${sources[@]}; do
  [ -f $src ] && . $src
done

# Use VI mode in bash
set -o vi
