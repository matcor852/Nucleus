# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/nucleuser/.config/oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="evan"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
	command-not-found
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# prevent su complaining about insecure dirs
export ZSH_DISABLE_COMPFIX='true'
source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR='vim'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


setopt autocd
setopt correct
unsetopt correct_all
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort

PROMPT_EOL_MARK=""

autoload -Uz compinit && compinit -d ~/.cache/zcompdump
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%b'

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-Z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

isNotGitRepo() {
    git status > /dev/null 2>&1
    [ $? -eq 128 ]
}

setopt promptsubst
preexec() {
	timer=$(($(date +%s%0N)/1000000))
}

# open new terminal in same dir
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)"
precmd() {
    vcs_info

    VENV=""
    if [ ! -z "$VIRTUAL_ENV" ]; then
        VENV="%F{magenta}$(basename "$VIRTUAL_ENV")%f"
        [ ! -z "$vcs_info_msg_0_" ] && VENV="$VENV %F{cyan}|%f "
    fi
    if [ -z "$VIRTUAL_ENV" ] && [ -z "$vcs_info_msg_0_" ]; then
        env_br=""
    else
        env_br="{%f $VENV%F{yellow}$vcs_info_msg_0_%f %F{cyan}}─"
    fi
    export env_br

    eval 'pwd > "${HOME}/.cwd"'
	print ""
	if [ "$timer" ]; then
		now=$(($(date +%s%0N)/1000000))
		elapsed=$(($now-$timer))
        printf -v ms "%03d" "$((elapsed%1000))"
		printf -v elapsed "%s%d.%ss" "$elf" "$((elapsed/1000))" "${ms:0:2}"
		export elapsed
		unset timer
	fi
}

configure_prompt() {
	PS='•'
	[ -z "$elapsed" ] && elapsed="0.00s"
    ps1=$'\r%F{cyan}┌──(%f%F{%(?.green.red)}%B%?%b%f%F{blue}%B$PS%b%f%F{white}${elapsed}%f%F{cyan})─${env_br}[%f%F{white}%~%f%F{cyan}]\n└─%f%F{blue}$ %f'
    su_ps1=$'\r%F{red}┌──(%f%F{%(?.green.red)}%B%?%b%f%F{blue}%B$PS%b%f%F{white}${elapsed}%f%F{red})─${env_br}[%f%F{white}%~%f%F{red}]\n└─%f%F{blue}%B%F{red}💀%f%b%f'
    [ "$EUID" -eq 0 ] && PROMPT="$su_ps1" || PROMPT="$ps1"
    #RPROMPT='%F{37}%*%f'
}

configure_prompt

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan-bold
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[command-substitution]=none
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
ZSH_HIGHLIGHT_STYLES[process-substitution]=none
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[assign]=none
ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
ZSH_HIGHLIGHT_STYLES[named-fd]=none
ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout

export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)


alias history="history 0"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias bat='batcat'
alias ezshrc='vim ~/.zshrc'
alias evimrc='vim ~/.vimrc'
#alias valgrind='valgrind --leak-check=full --track-fds=yes'
alias python='python3'
alias gs='git status'
alias gd='git diff --color-words'
alias su='sudo -i'


activate() {
    matches=()
    while IFS= read -r -d $'\0'; do
        matches+=("$REPLY")
    done < <(find . -path '*/bin/activate' -print0)
    nb="${#matches[@]}"
    [ "$nb" -eq 0 ] && echo "No virtual env found." && return 1
    choice=1
    if [ "$nb" -gt 1 ]; then
        echo "Found $nb matches, choose one of:\n"
        for (( i=1; i<="$nb"; i++ )); do
            echo " $i: ${matches[$i]}"
        done
        printf "\nchoice: "
        read choice
        while [ ! "$choice" =~ ^[0-9]+$ ] || [ "$choice" -gt "$nb" ] || [ "$choice" -lt 1 ]; do
            printf "Invalid choice, retry: "
            read choice
        done
    fi
    source "${matches[$choice]}"
    echo "Activating ${matches[$choice]}"
}


gitadd() {
    isNotGitRepo && echo "Not in a git repository" && return 2
    for arg; do
        ext="${arg##*.}"
        if [ "$ext" = "c" ] || [ "$ext" = "h" ]; then
            clang-format --Werror --dry-run --style=file:~/.epita-format -i "$PWD/$arg"
            clang-format --style=file:~/.epita-format -i "$PWD/$arg"
        fi
        git add "$PWD/$arg"
    done
}

pushtag() {
    isNotGitRepo && echo "Not in a git repository" && return 2
    [ "$#" -ne 1 ] && echo "Usage: pushtag [tag pattern:str]" && return 1
    git commit -m "$1";
    git push;
    git tag -ma "$1";
    git push origin "$1";
}

export PGDATA="$HOME/.postgres_data"
export PGHOST="/tmp"
export PATH=$PATH:/usr/lib/postgresql/
alias initdb="/usr/lib/postgresql/*/bin/initdb"
alias postgres="/usr/lib/postgresql/*/bin/postgres"

# alias java="/home/nucleuser/.jdks/corretto-17.0.11/bin/java"
# export JAVA_HOME="/home/nucleuser/.jdks/corretto-17.0.11"
# alias mvn="/home/nucleuser/.local/share/JetBrains/Toolbox/apps/intellij-idea-ultimate/plugins/maven/lib/maven3/bin/mvn"

export PYTHONDONTWRITEBYTECODE=1

