let
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable") {};
in
[
  nixpkgs.inetutils
  nixpkgs.gnused
  nixpkgs.git
  nixpkgs.micro
  nixpkgs.mc
  nixpkgs.tmux
  nixpkgs.fzf
  nixpkgs.fd
  nixpkgs.delta
  nixpkgs.hexyl
  nixpkgs.remarshal
  nixpkgs.chezmoi
]
