[ -z "$PS1" ] && return

__PATH__=$(cd $(dirname "$0"); pwd)

if [ "`uname`" = "Darwin" ]; then
  _MAC=1
else
  _MAC=0
fi

export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth

if [ "$_MAC" = "1" ]; then
  shopt -s checkwinsize
fi

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#case "$TERM" in
#xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
if [ "`id -u`" = "0" ]; then
    export PS1='\[\e[31;1m\]\h\[\e[m\]:\W\$ '
fi
export PS1='$(git-PS1)'$PS1

if [ "$_MAC" = "0" ]; then
  case "$TERM" in
  xterm*|rxvt*)
      PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
      ;;
  *)
      ;;
  esac
fi

# All platforms: bash aliases
for i in $__PATH__/aliases/*; do
  . $i
done

# Linux only: enable color support of ls and also add handy aliases
if [ "$_MAC" = 0 ]; then
  if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
  fi
fi

# All platforms: add bash completion for many many binaries
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
if [ -f ~/etc/bash_completion ]; then
  . ~/etc/bash_completion
fi

export PATH=$PATH:$__PATH__/bin
export EDITOR=vim

# Linux only: if system does not provides a RedHat like "service" binary, emulate it
if [ "$_MAC" = "0" ]; then
  if [ "`id -u`" = "0" ]; then
    service()
    {
      /etc/init.d/$1 $2;
    }
  else
    service()
    {
      sudo /etc/init.d/$1 $2;
    }
  fi
fi

# MacOSX only: if MacPorts is installed, add its binary path to system PATH
if [ "$_MAC" = "1" -a -d /opt/local/bin/ ]; then
  export PATH=/opt/local/bin/:$PATH

  if [ "`id -u`" = "0" -a -d /opt/local/sbin/ ]; then
    export PATH=/opt/local/sbin/:$PATH
  fi

  if [ -d /opt/local/share/man ]; then
    export MANPATH=/opt/local/share/man:$MANPATH
  fi
fi

