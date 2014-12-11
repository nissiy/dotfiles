# set color
local RED=$'%{\e[31m%}'
local GREEN=$'%{\e[32m%}'
local YELLOW=$'%{\e[33m%}'
local BLUE=$'%{\e[34m%}'
local DEFAULT=$'%{\e[m%}'

# PROMPT
PS1="$GREEN${USER}@${HOST%%.*}$DEFAULT:$BLUE%~$DEFAULT%(!.#.$) " # ユーザ@ホスト:カレントディレクトリ
RPROMPT="%T" # 右側に時間を表示する
setopt transient_rprompt # 右側まで入力がきたら時間を消す
setopt prompt_subst # 便利なプロント
bindkey -e #emacsライクなキーバインド

# ターミナルのタイトルに「ユーザ@ホスト:カレントディレクトリ」を表示
case "${TERM}" in
kterm*|xterm)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  ;;
esac 

export LANG=ja_JP.UTF-8 # 日本語環境
export EDITOR=vi # エディタはvim

autoload -U compinit # 強力な補完機能
compinit -u # このあたりを使わないとzsh使ってる意味なし
setopt autopushd # cdの履歴を表示
setopt pushd_ignore_dups # 同ディレクトリを履歴に追加しない
setopt auto_cd # 自動的にディレクトリ移動
setopt list_packed # リストを詰めて表示
setopt list_types # 補完一覧ファイル種別表示

# 履歴
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # 重複を記録しない
setopt hist_reduce_blanks # スペース排除
setopt share_history # 履歴ファイルを共有
setopt EXTENDED_HISTORY # zshの開始終了を記録
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える

# history 操作まわり
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# alias
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完の時に大文字小文字を区別しない

#if [ -x /usr/local/opt/coreutils/libexec/gnubin/dircolors ]; then # for Mac
if [ -x /usr/bin/dircolors ]; then # for Linux
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
fi

alias searchall="find . -name '*' | xargs grep -i "
alias searchsh="find . -name '*.sh' | xargs grep -i "
alias searchjs="find . -name '*.js' | xargs grep -i "
alias searchphp="find . -name '*.php' | xargs grep -i "
alias searchcss="find . -name '*.css' | xargs grep -i "
alias searchscss="find . -name '*.scss' | xargs grep -i "
alias searchruby="find . -name '*.rb' | xargs grep -i "
alias searchjava="find . -name '*.java' | xargs grep -i "
alias ll="ls -l"

# alias for Android
alias dumpsys="adb shell dumpsys"
alias activityrecord="dumpsys activity | grep -B 1 \"Run #[0-9]*:\""
alias fragmentrecord="dumpsys activity top | grep -B 1 \"#[0-9]*:\""

# ssh-agent自動起動[for Linux]
agentPID=`ps gxww|grep "ssh-agent]*$"|awk '{print $1}'`
agentSOCK=`/bin/ls -t /tmp/ssh*/agent*|head -1`
if [ "$agentPID" = "" -o "$agentSOCK" = "" ]; then
  unset SSH_AUTH_SOCK SSH_AGENT_PID
  eval `ssh-agent`
  ssh-add < /dev/null
else
  export SSH_AGENT_PID=$agentPID
  export SSH_AUTH_SOCK=$agentSOCK
fi
