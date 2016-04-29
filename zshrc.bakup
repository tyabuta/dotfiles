echo "import ~/.zshrc"

bindkey -v              # キーバインドをviモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }


# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

### Title (user@hostname) ###
case "${TERM}" in
kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac


# -----------------------------------------------
# functions
# -----------------------------------------------

# phpファイルのgrep検索
# php-file-grep <Keyword-RegExp>
function php-file-grep(){
  local keyword=$1
  find ./ -iname "*.php" | xargs grep -n "$keyword"
}

# カレントディレクトリ以下のファイル全てを対象に権限変更
# chmod-files <Permission>
function chmod-files(){
  local permission=$1
  find ./ -type f -print | xargs chmod --verbose $permission
}

# カレントディレクトリ以下のディレクトリ全てを対象に権限変更
# chmod-dirs <Permission>
function chmod-dirs(){
  local permission=$1
  find ./ -type d -print | xargs chmod --verbose $permission
}

#
# プロセス表示関数
#
proc() {
    # 引数なしなら、すべてのプロセスを表示する。
    ! ps aux | grep "$1" && ps aux
}

#
# grep -i <RegEx> [File]
#
search-regex(){
    if [ "" == "$1" ]; then
        echo "usage: search-regex <RegEx> [File]"
    else
        grep -i "$1" "$2"
    fi
}

#
# PATHが一致するファイルを出力する。
# find . -iname <FileName>
#
search-file-with-name(){
    if [ "" == "$1" ]; then
        echo "usage: search-file-with-name <FileName>"
    else
        find . -iname "$1"
    fi
}

#
# PATHが正規表現にマッチするファイルを出力する。
# find . -iname <RegEx>
#
search-file-with-regex(){
    if [ "" == "$1" ]; then
        echo "usage: search-file-with-regex <RegEx>"
    else
        find . -regex "$1"
    fi
}

#
# テキストファイルのエンコードをUTF-8に変換する。
# nkf -w <Source> <Output>
#
encode-utf8(){
    if [ "" == "$1" -o "" == "$2" ]; then
        echo "usage: encode-utf <Source> <Output>"
    else
        nkf -w "$1" > "$2"
    fi
}

#
# 環境変数PATHに新しいPathを通す。
#
path-insert(){
    if [ "" == "$1" ]; then
        echo "udage: path-insert <Path>"
    else
        export PATH="$1:$PATH"
    fi
}

#
# カレントディレクトリのファイルサイズが大きいものTOP10を出力する
#
file-size-top(){
  du -s * | sort -nr | head -10
}



# -----------------------------------------------
# alias設定
# -----------------------------------------------
alias cls="clear"

alias rmf="rm -Rf"
alias vimsudo="sudo -H vim"
alias desktop="cd ~/Desktop"
alias dotfiles="cd ~/dotfiles"
alias download="curl -L -O"
alias screenx="screen -xR"
alias top="top -d 5"
alias watch-ps-user='watch --interval=5 "ps ux"'

# diff -u -b
alias diff="diff --unified --ignore-space-change"


# tmux のセッションを呼び出す。
# 起動していない場合はセッション作成を行う。
alias tmux="! tmux a > /dev/null 2>&1 && tmux > /dev/null 2>&1 "

alias wgetall="wget --recursive --no-clobber --page-requisites --html-extension --convert-links --no-parent"

# cygwin環境を想定したaliaus
# ipconfigをifconfigのように使用する為、perlワンライナーで文字コード変換する
if which ipconfig >/dev/null 2>&1 && which perl >/dev/null 2>&1; then
    alias ifconfig="ipconfig | perl -MEncode -pe 'Encode::from_to(\$_,q{shiftjis},q{utf-8});'"

    alias ifconfig-renew="ipconfig /renew | perl -MEncode -pe 'Encode::from_to(\$_,q{shiftjis},q{utf-8});'"
fi


# -----------------------------------------------
# Git関係
# -----------------------------------------------

#export GIT_SSL_NO_VERIFY=true

alias git-status="git status"

# ステージングしたワークツリーとのdiffを表示する。
alias git-diff-cached="git diff --cached"

# git submodule init/update を兼ねたクローン
alias git-clone="git clone --recursive"

# 全てのブランチを表示
alias git-branches="git branch -a"

# git submoduleの更新を行う。
alias git-submodules-update="git submodule foreach 'git pull origin master'"

#
# カレントディレクトリのリポジトリ用にGitWebを立ち上げる。
# デーモンを停止させる時は、git-instaweb stop とする。
#
alias git-instaweb="git  instaweb --http=webrick"

# git commit の省略
git-commit(){
    if [ "" != "$1" ]; then
        git commit -m "$1"
    else
        git commit
    fi
}

alias git-checkout-patch="git checkout --patch"


# 変更・追加・削除ファイルを重複なしで列挙する
# git-log-change-files [--since=<Date>] [--author=<Author>]
function git-log-change-files(){
    options="$@"
    git log --name-status $options | grep -e "^[AMD]\b" | cut -f 2 | sort | uniq
}

function git-spull(){
    git stash
    git pull
    git stash pop
}

function setenv(){
    cd $WORKDIR
    screen -xR
}


# Java
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

# -----------------------------------------------
# ls設定
# -----------------------------------------------

alias ls="ls --color=auto"
alias la="ls -lha"

if [[ "Darwin" = "$UNAME" ]]; then # Mac用
    alias ls="ls -G"
    export CLICOLOR=1
    export LSCOLORS=CxGxcxdxCxegedabagacad

elif [[ "$UNAME" =~ "CYGWIN" ]]; then
    alias ls="ls -h --color=tty"
fi


