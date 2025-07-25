ARG CHEZMOI_BRANCH=main
ARG ARCH_IMG=archlinux


FROM ubuntu:22.04 AS base_ubuntu22
ARG BASE_UID=1000
ARG BASE_GID=1000
ARG BASE_USER
ENV BASE_HOME=/home/$BASE_USER
ARG CHEZMOI_BRANCH
ENV DEBIAN_FRONTEND=noninteractive
ENV __is_vm=1
COPY . /tmp/
RUN apt-get update && \
    apt-get -qqy install sudo curl && \
    apt-get clean && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN bash /tmp/useradd.sh
USER $BASE_USER
WORKDIR $BASE_HOME
ENV USER=$BASE_USER
RUN bash /tmp/main1.sh
ENV LANG=ja_JP.utf-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.utf-8
ENV PATH="$BASE_HOME/.local/bin:$BASE_HOME/.cargo/bin:$PATH"


FROM ubuntu:20.04 AS base_ubuntu20
ARG BASE_UID=1000
ARG BASE_GID=1000
ARG BASE_USER
ENV BASE_HOME=/home/$BASE_USER
ARG CHEZMOI_BRANCH
ENV DEBIAN_FRONTEND=noninteractive
ENV __is_vm=1
COPY . /tmp/
RUN apt-get update && \
    apt-get -qqy install sudo curl && \
    apt-get clean && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN bash /tmp/useradd.sh
USER $BASE_USER
WORKDIR $BASE_HOME
ENV USER=$BASE_USER
RUN bash /tmp/main1.sh
ENV LANG=ja_JP.utf-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.utf-8
ENV PATH="$BASE_HOME/.local/bin:$BASE_HOME/.cargo/bin:$PATH"


FROM $ARCH_IMG AS base_arch
ARG BASE_UID=1000
ARG BASE_GID=1000
ARG BASE_USER
ENV BASE_HOME=/home/$BASE_USER
ARG CHEZMOI_BRANCH
ENV LANG=C.utf-8
ENV __is_vm=1
COPY . /tmp/
# tar for chezmoi on arm64
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm sudo curl tar && \
    pacman -Scc --noconfirm
RUN bash /tmp/useradd.sh
USER $BASE_USER
WORKDIR $BASE_HOME
# ↓なぜか要る
ENV USER=$BASE_USER
RUN bash /tmp/main1.sh
ENV PATH="$BASE_HOME/.local/bin:$BASE_HOME/.cargo/bin:$PATH"


FROM homebrew/brew AS base_brew
# uid=1000, user=linuxbrew
ARG BASE_USER
ARG CHEZMOI_BRANCH
ENV LANG=C.utf-8
ENV __is_vm=1
COPY . /tmp/
ENV USER=linuxbrew
USER linuxbrew
WORKDIR /home/linuxbrew
RUN bash /tmp/main1.sh
ENV PATH="$BASE_HOME/.local/bin:$BASE_HOME/.cargo/bin:$PATH"


FROM ubuntu:22.04 AS base_nix
ARG BASE_UID=1000
ARG BASE_GID=1000
ARG BASE_USER
ENV BASE_HOME=/home/$BASE_USER
ARG CHEZMOI_BRANCH
ENV DEBIAN_FRONTEND=noninteractive
ENV __is_vm=1
COPY . /tmp/
RUN apt-get update && \
    apt-get -qqy install sudo curl xz-utils gnupg2 && \
    apt-get clean
# RUN nix-shell -p su --run bash ./docker_useradd.sh
RUN bash /tmp/useradd.sh && \
    mkdir /nix && chown $BASE_USER /nix
USER $BASE_USER
WORKDIR $BASE_HOME
ENV NIX_SHELL_PRESERVE_PROMPT=1
ENV PATH="$BASE_HOME/.nix-profile/bin:${PATH}"
RUN curl -L https://nixos.org/nix/install | sh && \
    nix-env -if /tmp/base144.nix && \
    chezmoi init --apply na-trium-144 --branch $CHEZMOI_BRANCH && \
    .local/share/chezmoi/utils/sublime.sh && \
    chezmoi apply --force
ENV LANG=ja_JP.utf-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.utf-8
