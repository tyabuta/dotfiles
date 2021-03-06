

export LANG="ja_JP.UTF-8"

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    #zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load mollifier/anyframe

    # bulk load
    zgen loadall <<EOPLUGINS
        zsh-users/zsh-history-substring-search
EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen oh-my-zsh themes/arrow

    # save all to init script
    zgen save
fi

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 1000

# ~/go
 if which go >/dev/null 2>&1; then
     export GOPATH="${HOME}/go"
     PATH="${GOPATH}/bin:$PATH"
 fi

# sdkman
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"


# qtdeploy
# homebrewでqt5をインストールした場合に必要な環境変数
export QT_HOMEBREW=true

# ~/ScriptTools
if [ -d "${HOME}/ScriptTools" ] ; then
    PATH="${HOME}/ScriptTools:$PATH"
fi


# スペースで始まるコマンドは履歴に残さない。
setopt hist_ignore_space

# alias
alias git-status="git status"
# ステージングしたワークツリーとのdiffを表示する。
alias git-diff-cached="git diff --cached"

# Keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"


# my anyframe
function my-anyframe-widget-put-git-branches(){
    anyframe-source-git-branch -a | perl -pe 's/^remotes\///' | perl -alne 'print $F[0]' | anyframe-selector-auto | anyframe-action-insert
}
zle -N -- my-anyframe-widget-put-git-branches

# anyframe key-bind
bindkey '^n^n' anyframe-widget-select-widget
bindkey '^ncd' anyframe-widget-cdr
bindkey '^nr'  anyframe-widget-put-history
bindkey '^nb'  my-anyframe-widget-put-git-branches

# my key-bind
if which wd >/dev/null 2>&1; then
    bindkey -s '^nw' `wd`
fi

bindkey -s '^nd' `date +'%Y-%m-%d'`

gosrc-look (){
    local selectedDir=$(gosrc list | fzf)
    gosrc look $selectedDir
}



