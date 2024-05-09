# dotfiles(chezmoi)

for Ubuntu, Arch Linux, MacOS, Windows(MSYS2)

```bash
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- -b ~/.local/bin init --apply na-trium-144 --destination $HOME
```

* MSYS2の場合は
	* chezmoiインストール前に
		* `pacman -S unzip`
		* `pacman -S git`または[git-for-windowsをインストール](https://github.com/git-for-windows/git/wiki/Install-inside-MSYS2-proper)
		* 環境変数にMSYS2_PATH_TYPE=inherit
* Macでは`brew install bash`で新しいbashが必要

## Contents
### bash
* ubuntuのデフォルトbashrcベース
* pathの設定(.local/bin, pyenv, nvm, fzf(使ってないけど), cargo, ruby)
* macの場合homebrewのパス, sublime textのパス, bash_completionの設定など
* git_ps1
	* dirtystate, stashstate, upstreamがオン
	* 2秒のタイムアウト機能付き
		* __git_ps1の結果を一時的に/dev/shmや/tmpに置くが他の場所にしたい場合`__git_ps1_file`を変更
* ps1(プロンプト)の変更
	* hostnameごとに顔文字を追加
	* pushdした数を表示
* 共通のaliasはscripts/bashに記述
* .bash_aliasesはchezmoi管理しないので環境特有の設定を置く(aliasではない)

### tmux
* prefixはctrl-j, alt-/
	* ssh内、docker内、環境変数`__is_vm`がある場合はctrl-b
* `$TERM`は`xterm-256color`なのでvimとかはバグるかも?
* [tpm](https://github.com/tmux-plugins/tpm)
	* [extrakto](https://github.com/laktak/extrakto)
	* [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
	* [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)
* prefix +
	* y: capture-pane → デフォルトのbuffer & clipboard
	* u: save-buffer
	* N: new-session
	* Tab: extrakto (画面右上)
		* msysだとバグる...
* copy-mode
	* Ctrl-z: begin-selection
	* Meta-left/right: previous/next-word
	* Space: copy-pipe-and-cancel → clipboard
* ステータスは独自のカスタマイズ
	* nerd fontが必要

### scripts
* bash: bashのalias, functionなど
	* `cbash` LANG=Cにし、nerd fontのプロンプトなどをオフにする
	* `cdpeco`, `pdpeco` fdでディレクトリを列挙→pecoで選択→cdまたはpushd
	* `diffl a b > c` aとbをマージしたファイルを生成 
	* MSYS2環境で
		* `syspath (command...)` PATHからmsysを消してコマンドを実行
		* `vsdevcmd22` VisualStudio2022のDeveloper Command Promptをひらく
		* `vsdevcmd19` VisualStudio2019
		* `lnj` フォルダのシンボリックリンクを作成(`mklink /j`)
		* `open (path)` ファイルorフォルダを(パスを変換して)explorerで開く
* tmux.ps.py: tmuxのステータスで使用 現在のjob数とプロセス数を表示

### utils
* misc.sh: いろいろインストールする
	* システムにインストール inetutils, micro, [peco](https://github.com/peco/peco), mc, tmux, fzf, cargo
	* cargoで入れる [fd-find](https://github.com/sharkdp/fd), [git-delta](https://github.com/dandavison/delta), [hexyl](https://github.com/sharkdp/hexyl)
	* tpm
* misc2.sh
	* nvm, npm, [git-user](https://github.com/geongeorge/Git-User-Switch)
	* その他 pyenv, ~~pipenv~~, poetry
* misc3.sh: メインの開発環境用
	* システムに cppcheck, tidy
	* pipで black, pylint, cmakelint, clang-format, mypy
	* npmで js-beautify, prettier
* chsh.sh: mac用 デフォルトシェルをbrewのbashに変更
* msys2.sh: MSYS2用
	* git, mc, tmux, fzf, fd, winpty, tpm, git-prompt
	* chocoが入っていればchoco経由でmicro, peco
		* pecoはmsys2で使えないけど...

### その他
* micro, peco, fd, sublime, poetryの設定とか
