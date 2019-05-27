# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.config/dircolors/dircolors.ansi-dark\
    && eval "$(dircolors -b ~/.config/dircolors/dircolors.ansi-dark)"\
    || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# help with butterfingers: correct small typos in directory names supplied to cd
shopt -s cdspell

# Enable the use of ** to glob directories and subdirectories (warning: can cause long searches,
# if directory tree is large)
shopt -s globstar

# git stuff
# based on https://jansblog.org/2011/05/30/bash-prompt-mit-git-informationen/
function parse_git_branch {
  local git_branch=$(git branch 2> /dev/null)
  local branch_pattern="\* ([^[:space:]]*)"
  if [[ ${git_branch} =~ ${branch_pattern} ]]; then
    echo "[${BASH_REMATCH[1]}]"
  fi
}
function my_prompt {
  # used special symbols:
  # - arc down and right: U+256d
  # - arc up and right: U+2570
  # - box horizontal: U+2500
  # - box down and right: U+250c
  # - box down and left: U+2510
  # - box left: U+2574
  # - box right: U+2576
  # Parts of the prompt:
  # - username: usually either my name or root \u
  # - working directory \w
  # - hostname \h
  # - maybe: clock/date \A, \d or \D{date format}
  # - maybe: job count \j
  # - $COLUMNS: number of cols in current terminal
  # - maybe: use blocks and frame elements starting from 0x2580
  # Colors xterm:
  # - start escape: \e[
  #   direct color: 38;2;0;R;G;B
  #   (other colors: see control sequence manual "CSI Pm m  Character Attributes (SGR)."
  #   end: m
  #   ex: \e[38;2;255;0;0m
  # TODO: strategy for very long branch names and working directory paths
  local last_prog=$?
  local front=$(echo -e "\u256d\u2500\u2574")
  local separator=$(echo -e "\u2576\u2500\u2574")
  local git_branch=$(parse_git_branch)
  local right_bar=$(echo -e -n "\u2576")
  local left_bar=$(echo -e -n "\u2574")
  if [[ -n "$git_branch" ]]; then
    git_branch="$left_bar$git_branch$right_bar"
  fi
  local baseline=$(for i in $(seq 22 $COLUMNS); do echo -e -n "\u2500"; done; echo -e -n "\u2574")
  local date=$(date +"%Y-%m-%d %H:%M:%S")
  PS1="$baseline$date$right_bar\r$front$last_prog$separator\u@\h$separator\w$right_bar$git_branch\n "
}

# See ctlseqs.txt of xterm for a list of Control Characters
# If this is an xterm set the title to user@host:dir
# PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
PROMPT_COMMAND=my_prompt
PS2=$(echo -e -n "\u25ba ")

source /usr/bin/virtualenvwrapper.sh
# machine specific bash files
if [ -f ~/.config/bash/local_mods ]; then
  . ~/.config/bash/local_mods
fi
