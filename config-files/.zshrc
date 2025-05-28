# -------------------------------------------------------------------
# --- Powerlevel10k -------------------------------------------------
# -------------------------------------------------------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# -------------------------------------------------------------------
# --- ZINIT ---------------------------------------------------------
# -------------------------------------------------------------------

# Set the ZINIT directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Check if zinit exists
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Powerlevel10K
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Other plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# load the plugins
autoload -U compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -------------------------------------------------------------------
# --- Keybindings and History ---------------------------------------
# -------------------------------------------------------------------
bindkey '^f' autosuggest-accept

# HISTORY Settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Remove last command executed from history if it was wrong
history_remove_failed() {
	if [[ $? -ne 0 ]]; then
		fc -R
	fi	
}

add-zsh-hook precmd history_remove_failed

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias tsession='bash ~/.tsession.sh'


# -------------------------------------------------------------------
# -- FZF ------------------------------------------------------------
# -------------------------------------------------------------------

# Shell integration of FZF
eval "$(fzf --zsh)"
