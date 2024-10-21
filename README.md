# dotfiles(chezmoi)

for Ubuntu, (Arch Linux,) MacOS, Windows(MSYS2)

```bash
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- -b ~/.local/bin init --apply na-trium-144 --destination $HOME
```

* bashが使う一時ファイルの場所を変えたい場合は`_tmp=$HOME`などとする(.bash_aliasesに書く)
* MSYS2の場合は
	* chezmoiインストール前に
		* `pacman -S unzip`
		* `pacman -S git` <del>または[git-for-windowsをインストール](https://github.com/git-for-windows/git/wiki/Install-inside-MSYS2-proper)</del>
			* git-for-windowsのほうだと勝手にcredential managerを入れたり、コンソールへの出力の色がおかしかったりする
		* 環境変数にMSYS2_PATH_TYPE=inherit
	* <del>HOMEはmsys側においてもいいが、それでもchezmoiのファイルは/c/Users側に置かれてしまう?</del>
	* HOMEは C:\msys64\home\ユーザー名 のまま使う
	* /etc/fstab を編集し、noaclを消す
	* `mkdir /c/Users/ユーザー名/.cache`
	* `lnj /c/Users/ユーザー名/.cache .cache`
	* sshの鍵は msys64/home/.ssh のほうに置く
	* sublimeの設定ファイル `lnj ~/.config/sublime-text/Packages/User '/c/Users/ユーザー名/AppData/Roaming/Sublime Text/Packages/User'`
* Macでは`brew install bash`で新しいbashが必要

## Contents
### bash
* ubuntuのデフォルトbashrcベース
* pathの設定(.local/bin, pyenv, nvm, fzf(使ってないけど), cargo, ruby)
* macの場合homebrewのパス, sublime textのパス, bash_completionの設定など
* 共通のaliasは scripts/aliases.sh に記述
* PS1は scripts/ps1.sh
* .bash_aliases はchezmoi管理しないので環境特有の設定を置く(aliasではないものも含む)

### tmux
* prefixは ctrl-j, alt-/
	* ssh内または環境変数`__is_vm`が1の場合は ctrl-b, alt-.
* `$TERM`は`xterm-256color`なのでvimとかはバグるかも?
* [tpm](https://github.com/tmux-plugins/tpm)
	* [extrakto](https://github.com/laktak/extrakto)
	* [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
	* [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)
* prefix +
	* y: capture-pane → デフォルトのbuffer & OSのclipboard
	* u: save-buffer to file
	* N: new-session
	* left/right = previous/next-window
	* home = new-window
	* v: OSのclipboardの内容をbufferにコピーしたうえでpaste-bufferする
	* Tab: extrakto (画面右上)
		* msysだとバグる...
* copy-mode
	* Ctrl-z: begin-selection
	* Meta-left/right: previous/next-word
	* Space: copy-pipe-and-cancel → clipboard
* ステータスは独自のカスタマイズ
	* nerd fontが必要

### scripts

* aliases.sh: bashのalias, functionなど
	* `no-pyenv` PATHからpyenvのshimを消す
	* `cbash` LANG=Cにし、nerd fontのプロンプトなどをオフにする
	* `cdpeco`, `pdpeco` fdでディレクトリを列挙→pecoで選択→cdまたはpushd
	* `diffl a b > c` aとbをマージしたファイルを生成 
	* `pd`=`pushd`
		* popdはpopd
	* `tb 文字列` でtmuxのバッファとOSのクリップボードにコピー、`tb` でバッファの内容を出力
	* `tw コマンド` でtmuxの新しいwindowを開いて現在のディレクトリでコマンドを実行
	* MSYS2環境で
		* `syspath (command...)` PATHからmsysを消してコマンドを実行
		* `vsdevcmd22` VisualStudio2022のDeveloper Command Promptをひらく
		* `vsdevcmd19` VisualStudio2019
		* `lnj` フォルダのシンボリックリンクを作成(`mklink /j`)
		* `open (path)` ファイルorフォルダを(パスを変換して)explorerで開く
* ps1.sh
	* git_ps1
		* dirtystate, stashstate, upstreamがオン
		* 2秒のタイムアウト機能付き
	* ps1(プロンプト)の変更
		* hostnameごとに顔文字を追加
		* pushdした数を表示
		* 直前のコマンドの終了コードを表示(0でない場合)
		* 直前のコマンドの実行時間を表示(5秒以上の場合)
		* .bashrcを読み込んだときにこのdotfilesのコミット数を表示
* win_open.sh: パスをWindows用に変換してexplorerで開く
	* MSYS2時に`open`コマンドとしてエイリアスを貼ってある
	* 環境変数`MC_XDG_OPEN`にも設定されているので、mcでファイルを開けばexplorer(→関連付けられたアプリ)で開いてくれる
<!-- * tmux.ps.py: tmuxのステータスで使用 現在のjob数とプロセス数を表示 -->

### utils

* brew_local.sh: linuxbrewを ~/.brew にインストールする (misc1より先に実行すること)
	* aptと干渉するのを避けるため、デフォルトではPATHを通していない
	* `brew-activate` でそのシェル内だけパスが通る
* misc.sh: いろいろインストールする
	* システムにインストール inetutils, git, curl, build-essential, micro, [peco](https://github.com/peco/peco), mc, tmux, fzf
	* 引数になにか渡すとcargo.shとsource_buildsを省略 (ビルドが重いラズパイなど)
* cargo.sh
	* [fd-find](https://github.com/sharkdp/fd), [git-delta](https://github.com/dandavison/delta), [hexyl](https://github.com/sharkdp/hexyl)
* source_builds/
	* doxygen 1.9.7
	* json-tui
	* mc (misc.shからは呼ばれない)
	* tmux (misc.shからは呼ばれない)
	* todo: micro, fzf, ...?
* tpm.sh
* misc2.sh
	* pyenv or pyenv-win で python3.12.5
		* pipで pipx
		* pipxで poetry
	* nvm or nvm-windows でlts
		* [git-user](https://github.com/geongeorge/Git-User-Switch)
* misc3.sh: メインの開発環境用
	* todo: MSYS2非対応
	* システムに cppcheck, ruby, tidy, shellcheck
	* pipxで black, pylint, cmakelint, clang-format, clang-tidy, mypy, flake8
	* npmで js-beautify, prettier
* git.sh: git-prompt.sh をダウンロードする MacとMSYS2用
* chsh.sh: mac用 デフォルトシェルをbrewのbashに変更
* chsh_docker.sh
* rtc.sh: dualboot環境で時刻がずれるのを修正するやつだった気がする
* sublime.sh: sublime textをいんすとーるする (Ubuntu)

### その他
* micro, peco, fd, sublime, poetryの設定とか
