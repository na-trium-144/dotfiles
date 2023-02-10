# dotfiles(chezmoi)

```
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- -b ~/.local/bin init --apply na-trium-144
```

## scripts
* bash: bashのalias, functionなど
	* `cbash` LANG=Cにし、nerd fontのプロンプトなどをオフにする
	* `cdpeco`, `pdpeco` fdでディレクトリを列挙→pecoで選択→cdまたはpushd
* tmux.ps.py: tmuxのステータスで使用 現在のjob数とプロセス数を表示

## utils
* misc.sh: いろいろインストールする
	* システムにインストール micro, [peco](https://github.com/peco/peco), mc, tmux, fzf, cargo
	* cargoで入れる [fd-find](https://github.com/sharkdp/fd), [git-delta](https://github.com/dandavison/delta), (あまり使ってないけど[hexyl](https://github.com/sharkdp/hexyl))
	* その他 pyenv, pipenv, tpm, [git-user](https://github.com/geongeorge/Git-User-Switch)
* subl-plugin.sh: メインの開発環境用
	* システムに cppcheck, tidy
	* pipで black, pylint, cmakelint
	* npmで js-beautify, prettier
* chsh.sh: mac用 デフォルトシェルをbrewのbashに変更
* onedrive.sh, sublime.sh
