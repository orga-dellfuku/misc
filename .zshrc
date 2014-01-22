### Command Search Path
#PATH=$HOME/bin:/opt/local/bin:/opt/local/sbin:/home/likingjp/bin:/home/likingjp/src:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/libexec:/usr/X11R6/bin:/$HOME/.perlbrew/bin; export PATH
#PATH=$HOME/bin:/home/likingjp/bin:/home/likingjp/src:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/libexec:/usr/X11R6/bin:/$HOME/.perlbrew/bin; export PATH
export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
export PERLBREW_ROOT=$HOME/.perlbrew
export PATH=$PATH:/Users/dellfuku/bin:/home/likingjp/bin:/home/likingjp/src:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/libexec:/usr/X11R6/bin://Users/dellfuku/.perlbrew/bin

BLOCKSIZE=M;    export BLOCKSIZE
EDITOR=vim;      export EDITOR
PAGER=less;     export PAGER
PAGER=less;     export MANPAGER

## Environment variable configuration

# LANG

export LANG=ja_JP.UTF-8

## Default shell configuration

# set prompt

autoload colors
colors

setopt prompt_subst
setopt prompt_percent
setopt transient_rprompt

c_normal="%{${fg[normal]}%}"
c_red="%{${fg[red]}%}"
c_green="%{${fg[green]}%}"
c_reset="%{${reset_color}%}"

case ${HOST} in
    y-172-27-137-164.kks.ynwm.yahoo.co.jp)
        export HOST=bsd03.img.ynwm.yahoo.co.jp
        ;;
        *)
        export HOST=${HOST} 
        ;;
esac

case ${UID} in
0)
    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
*)
    PP="%{${fg[green]}%}$%{${reset_color}%}"
    RPROMPT="%{${fg[red]}%}[%/]%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    prompt_left="%{${fg[cyan]}%}[%D{%Y/%m/%d %H:%M:%S}]%{${reset_color}%}"
    prompt_left2="%{${fg[yellow]}%}[%n@%M:$YROOT_NAME]%{${reset_color}%}"
    uname=`uname`
    #face="%(?.${c_nomal}(*ﾟｪﾟ*)${c_reset}.${c_red}(TｪT%)${c_reset})"
    prompt_left3="%{${fg[magenta]}%}[#%h]${c_reset}${c_green}[${uname}]${c_reset} ${PP} ";
    PROMPT="${prompt_left}${prompt_left2}"$'\n'"${prompt_left3}"
    ;;
esac

autoload -Uz is-at-least

if is-at-least 4.3.10; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' formats '[%s:%b]'
    zstyle ':vcs_info:*' actionformats '[%s:%b|%a]'

    _precmd_vcs_info () {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }

    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _precmd_vcs_info
    prompt_left3="${c_green}[${uname}]${c_reset}%1(v|%F{magenta}%1v%f|) ${PP} ";
        PROMPT="${prompt_left}${prompt_left2}"$'\n'"${prompt_left3}"
fi

# auto change directory

setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]

setopt auto_pushd

# command correct edition before each completion attempt

setopt correct

# compacked complete list display

setopt list_packed

# no remove postfix slash of command line

setopt noautoremoveslash

# no beep sound when complete list displayed

setopt nolistbeep

## Keybind configuration

# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
#   to end of it)

bindkey -e

setopt auto_param_slash
setopt brace_ccl
setopt magic_equal_subst
setopt auto_param_keys
setopt mark_dirs
setopt long_list_jobs

# historical backward/forward search with linehead string binded to ^P/^N

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


## Command history configuration

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt inc_append_history

# Completion configuration

fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit

_cache_hosts=(`cut -d' ' -f1 ~/.ssh/known_hosts | cut -d, -f1`)
compctl -k _cache_hosts yssh ssh sssh
compctl -S ':' -k _cache_hosts + -f yscp scp

## Alias configuration

# expand aliases before completing

setopt complete_aliases     # aliased ls needs if file/dir completions work

alias ls="ls -aG"
alias sudo="sudo -E "
alias less="less --tabs=2 -MNw"
alias vi="vim"
alias c="clear"
alias rm="rm -rvf"
alias php="php"
alias ruby="ruby"
alias s="screen"
alias cp="cp -rv"
alias tmux="tmux attach"
alias grep="grep --color=auto"

# man convert jman
#alias man="jman"

export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LSCOLORS=gxfxcxdxbxegedabagacad

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:default' menu select=2
#zstyle ':completion:*' completer \
#    _oldlist _complete _match _ignored _approximate _prefix

zstyle ':completion:*' list-colors \
              'di=;36;36' 'ln=;35;35' 'so=;32;32' 'ex=31;31' 'bd=46;34' 'cd=43;34'



update_title() {
    local command_line=
    typeset -a command_line
    command_line=${(z)2}
    local command=
    if [ ${(t)command_line} = "array-local" ]; then
        command="$command_line[1]"
    else
        command="$2"
    fi
    print -n -P "\e]2;"
    echo -n "(${command})"
    print -n -P " %n@%m:%~\a"
}

if [ -n "$DISPLAY" ]; then
    preexec_functions=($preexec_functions update_title)
fi

#if [ -f ~/.zsh/auto-fu.zsh ]; then
#    source ~/.zsh/auto-fu.zsh
#    function zle-line-init () {
#        auto-fu-init
#    }
#    zle -N zle-line-init
#fi
#source ~/work/zsh-git-prompt/zshrc.sh
#PROMPT='%B%m%~%b$(git_super_status) %#'
