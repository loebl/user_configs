# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
# 	. "$HOME/.bashrc"
#     fi
# fi

# set ecasound variable for SSR
export ECASOUND="ecasound"
# set default alsa card to PCH, as HDMI takes place as first card
export ALSA_CARD="PCH"
# default editor to use
export EDITOR=vim
# add pkgconfig for local ssr installation
export PKG_CONFIG_PATH=/opt/ssr/lib/pkgconfig
# add Go path
export PATH=$PATH:$HOME/go/bin
# add path for virtual envs
export WORKON_HOME=~/.virtualenvs
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# start graphical session if on virtual terminal one
if [ -z $DISPLAY ] && [ -n $XDG_VTNR ] && [ 1 -eq $XDG_VTNR ]; then
  exec startx > xserver.log 2>&1
fi
