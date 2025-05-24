# Configuración de Java para entornos gráficos
export _JAVA_AWT_WM_NONREPARENTING=1

# Configuración de Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Historial mejorado
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt extended_history       # Registra timestamp
setopt hist_expire_dups_first # Elimina duplicados primero
setopt hist_ignore_space      # Ignora comandos que empiezan con espacio
setopt share_history          # Comparte historial entre sesiones

# Sistema de autocompletado moderno
autoload -Uz compinit && compinit -i # -i ignora seguridad para carga más rápida
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' group-name ''

# Configuración de Powerlevel10k (eliminado el promptinit redundante)
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# PATH optimizado y sin duplicados
path=(
    ~/.local/bin
    /usr/local/{bin,sbin}
    /usr/{bin,sbin}
    /{bin,sbin}
    /snap/bin
    /usr/share/games
    /usr/games
    $path
)
export PATH

# Aliases mejorados con protección contra override
alias ls='lsd --group-dirs=first'
alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lAh'
alias cat='bat --paging=never'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'

# Configuración de FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Plugins con verificación de existencia
ZSH_PLUGINS_DIR="/usr/share/zsh/plugins"
[[ -f $ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && 
    source $ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f $ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && 
    source $ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh

# Funciones mejoradas
function mkt() {
    mkdir -p {nmap,content,exploits,scripts} && tree
}

function extractPorts() {
    local file="${1:-nmap*.xml}"
    local ports=$(grep -oP '\d{1,5}/open' $file | cut -d/ -f1 | sort -nu | paste -sd ',')
    local ip=$(grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' $file | sort -u | head -n1)
    
    echo -e "\n[*] IP: \033[1;32m$ip\033[0m"
    echo -e "[*] Puertos abiertos: \033[1;33m$ports\033[0m\n"
    echo $ports | xclip -sel clip
    echo "[*] Puertos copiados al portapapeles"
}

function man() {
    env \
    LESS_TERMCAP_mb=$'\e[1;31m' \
    LESS_TERMCAP_md=$'\e[1;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;44;33m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;32m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    man "$@"
}

function fzf-lovely() {
    local preview='bat --color=always --style=numbers,changes --line-range :500 {}'
    [[ "$1" = "h" ]] && fzf -m --reverse --preview-window down:60% --preview "$preview"
    fzf -m --preview "$preview"
}

function rmk() {
    [[ -f "$1" ]] && {
        scrub -p dod "$1"
        shred -zun 10 -v "$1"
    }
}

# Finalizar configuración de Powerlevel10k
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize
