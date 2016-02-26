# Use colors
export CLICOLOR=1

# Colors when outputing file lists
export LSCOLORS=gxgxcxdxbxegedabagacad

# Store 10,000 history entries
export HISTSIZE=10000
# Don't store duplicates
export HISTCONTROL=erasedups
# Append to history file
shopt -s histappend

# Use vim as the editor
export VISUAL=vim

#export DISPLAY=:0.0
#export EDITOR="$VISUAL"
#export GEMDOC=$(\gem environment gemdir)/doc
#export LC_CTYPE=en_US.UTF-8
#export LESS="FRX"
#export PGOPTIONS='-c client_min_messages=WARNING'
#export PSQL_EDITOR='vim -c"set syntax=sql"'
#export RI="--format ansi --width 80"
#export RSPEC=true
#export AUTOFEATURE=true

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize


[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# Colours
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"
       GRAY="\[\033[1;30m\]"

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=true

function parse_git_branch {
  if test -n __git_ps1; then
    # branch_parse="\(([^\s])[\s]([\*\+\$\%<>\=]*)?\)"
    # branch_parse="\(([^ ]*)[ ]?([\*\+\$\%]*)(.*)\)"
    branch_parse="\(([^ \*\+\$\%\<\>\=]*)[ ]?([\*\+\$\%]*)(.*)\)"
    state=""
    # unstaged (*)
    # staged (+)
    # stashed ($)
    # untracked (%)

    # behind (<)
    # ahead (>)
    # diverged (<>)

    if [[ `__git_ps1` =~ $branch_parse ]]; then
      branch=${BASH_REMATCH[1]}
      local_match=${BASH_REMATCH[2]}
      remote_match=${BASH_REMATCH[3]}
      color="${GREEN}"
      state=""
      remote_status=""

      for ((i=0; i < ${#local_match}; i++))
      do
        case ${local_match:$i:1} in
          '*')
            color="${RED}"
            state="$state${RED}⁉";;
          '+')
            color="${GREEN}"
            state="$state${GREEN}‼";;
          '$')
            color="${YELLOW}"
            state="$state${COLOR_NONE}🗒 ";;
          '%')
            color="${YELLOW}"
            state="$state${COLOR_NONE}💩 ";;
        esac
      done

      for ((i=0; i < ${#remote_match}; i++))
      do
        case ${remote_match:$i:1} in
          '<>')
            # diverged
            color="${RED}"
            remote_status="$remote_status${YELLOW}↕️";;
          '>')
            # ahead
            color="${GREEN}"
            remote_status="$remote_status${YELLOW}↑";;
          '<')
            # behind
            color="${RED}"
            remote_status="$remote_status${YELLOW}↓";;
          '=')
        esac
      done

      git_status="$(git status 2> /dev/null)"

      if [[ ! ${git_status}} =~ "working directory clean" ]]; then
        state="$state${RED}⚡"
      fi

      # return the output you want here
      echo "${LIGHT_GRAY}\w $color($branch)${COLOR_NONE}$state$remote_status"
    else
      echo "${LIGHT_GRAY}\w"
    fi
  fi
}

#sets what the prompt should be
function prompt_func() {
  previous_return_value=$?;
  prompt="$(parse_git_branch)${COLOR_NONE}"
  if test $previous_return_value -eq 0
  then
    PS1="${GREEN}➜  ${COLOR_NONE}${prompt}${GREEN} \$${COLOR_NONE} "
  else
    PS1="${RED}➜  ${COLOR_NONE}${prompt}${RED} \$${COLOR_NONE} "
  fi
}

PROMPT_COMMAND=prompt_func

[ -f "$HOME/.bash_profile.local" ] && . "$HOME/.bash_profile.local"

true
