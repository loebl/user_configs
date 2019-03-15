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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

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

# if set, enable vi keybindings instead of emacs. It always starts in insert mode
# Can also be set for all readline programs in .inputrc
# set -o vi

# help with butterfingers: correct small typos in directory names supplied to cd
shopt -s cdspell

# Enable the use of ** to glob directories and subdirectories (warning: can cause long searches,
# if directory tree is large)
shopt -s globstar

# default editor to use
export EDITOR=vim

# TODO: add PS1 configuration. Git repo detection would be useful (list current branch?). Git-sh and
# git-prompt already did something light this.
# See ctlseqs.txt of xterm for a list of Control Characters
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	# control sequence: OSC Ps ; Pt BEL
	# Ps:
	# - 0 -> change icon name and window title to Pt
	# - 1 -> change icon name to Pt
	# - 2 -> change window title to Pt
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# machine specific bash files
if [ -f ~/.config/bash/local_mods ]; then
  . ~/.config/bash/local_mods
fi
