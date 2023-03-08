# dotfiles(chezmoi)

for Ubuntu, Arch Linux, MacOS, Windows(MSYS2)

```bash
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- -b ~/.local/bin init --apply na-trium-144
```

## MSYS2の場合は
* chezmoiインストール前に`pacman -S unzip`
* `mklink /j \msys64\home\ユーザー名 \Users\ユーザー名`が必要
* gitconfigに core.fileMode=false
* msys2の起動コマンド例:
```
C:\Windows\System32\cmd.exe /c "set MSYSTEM=MINGW64&& set MSYS2_PATH_TYPE=inherit&& C:\msys64\ucrt64.exe"
```
これを呼び出すショートカットをAppData\Roaming\Microsoft\Windows\Start Menu\Programs\MSYS2とかに追加

## Contents
### bash
* ubuntuのデフォルトbashrcベース
* pathの設定(.local/bin, pyenv, nvm, fzf(使ってないけど), cargo, ruby)
* macの場合homebrewのパス, sublime textのパス, bash_completionの設定など
* git_ps1
	* dirtystate, stashstate, upstreamがオン
* ps1(プロンプト)の変更
	* hostnameごとに顔文字を追加
	* pushdした数を表示
* aliasはscripts/bashを参照

### tmux
* prefixはctrl-j
	* ssh内、docker内はctrl-b	
* `$TERM`は`xterm-256color`なのでvimとかはバグるかも?
* [tpm](https://github.com/tmux-plugins/tpm)
	* [extrakto](https://github.com/laktak/extrakto)
	* [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
	* [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)
* prefix +
	* y: capture-pane → デフォルトのbuffer & clipboard
	* u: save-buffer
	* Tab: extrakto (画面右上)
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
* tmux.ps.py: tmuxのステータスで使用 現在のjob数とプロセス数を表示

### utils
* misc.sh: いろいろインストールする
	* システムにインストール inetutils, micro, [peco](https://github.com/peco/peco), mc, tmux, fzf, cargo
	* cargoで入れる [fd-find](https://github.com/sharkdp/fd), [git-delta](https://github.com/dandavison/delta), (あまり使ってないけど[hexyl](https://github.com/sharkdp/hexyl))
	* nvm, npm, [git-user](https://github.com/geongeorge/Git-User-Switch)
	* その他 pyenv, pipenv, tpm
* subl-plugin.sh: メインの開発環境用
	* システムに cppcheck, tidy
	* pipで black, pylint, cmakelint, clang-format
	* npmで js-beautify, prettier
* chsh.sh: mac用 デフォルトシェルをbrewのbashに変更
* msys2.sh: MSYS2用
	* git, mc, tmux, fzf, fd, micro, winpty, tpm, git-prompt

### その他
* micro, peco, fd, sublime, poetryの設定とか
