# .bashrcにあるものとおなじ
export _hostname=$(hostname)
export _uname=$(uname) # Darwin, Linux, MINGW64_NT_*
echo "${_uname}" | grep MINGW64 >/dev/null && _uname=MINGW64_NT
export LANG=${LANG:-"C.UTF-8"} # "C" or "C.UTF-8" or other
export _chezmoi_root="${HOME}/.local/share/chezmoi"
[[ -d $_chezmoi_root ]] || export _chezmoi_root=$(echo /c/Users/*/.local/share/chezmoi)
[[ -d $_chezmoi_root ]] || echo "chezmoi root not found!"
export _winhome="/c/Users/$(basename ${HOME})"
