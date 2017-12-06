# $OpenBSD: dot.profile,v 1.4 2005/02/16 06:56:57 matthieu Exp $
#
# sh/ksh initialization

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games:.
export PATH HOME TERM

export LC_CTYPE=en_US.UTF-8
export GTK_IM_MODULE=xim
export LESSCHARSET=utf-8

set -o vi
set -o csh-history

x=$(print \\001)
PS1="$x$(print \\r)$x$(tput so)$x\$PWD$x$(tput se)$x> "

HISTFILE=$HOME/.sh_history
