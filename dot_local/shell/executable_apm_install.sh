#!/bin/sh
for p in `cat ~/.local/shell/apm_list`; do
	echo $p
	apm install $p
done


