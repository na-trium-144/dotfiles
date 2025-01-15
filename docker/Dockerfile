ARG ARCH_IMG


FROM ubuntu:22.04 AS base_ubuntu22
ARG BASE_UID=1000
ARG BASE_GID=1000
ARG BASE_USER
ENV BASE_HOME=/home/$BASE_USER
ENV DEBIAN_FRONTEND=noninteractive
# sublime-textを使うためには ja_JP.utf-8 にし、 language-pack-ja-base, langage-pack-ja が必要
ENV LANG=C.utf-8
ENV __is_vm=1
COPY . /tmp/
RUN apt-get update && \
    apt-get -qqy install sudo curl python3 && \
    apt-get clean && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN bash /tmp/useradd.sh
USER $BASE_USER
WORKDIR $BASE_HOME
RUN bash /tmp/main1.sh
ENV PATH="$BASE_HOME/.local/bin:$BASE_HOME/.cargo/bin:$PATH"


FROM $ARCH_IMG AS base_arch
ARG BASE_UID=1000
ARG BASE_GID=1000
ARG BASE_USER
ENV BASE_HOME=/home/$BASE_USER
ENV LANG=C.utf-8
ENV __is_vm=1
COPY . /tmp/
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm sudo curl && \
    pacman -Scc --noconfirm
RUN bash /tmp/useradd.sh
USER $BASE_USER
WORKDIR $BASE_HOME
COPY --from=base_ubuntu22 /home/$BASE_USER/.cargo $BASE_HOME/.cargo
COPY --from=base_ubuntu22 /home/$BASE_USER/.local/bin/doxygen $BASE_HOME/.local/bin/doxygen
COPY --from=base_ubuntu22 /home/$BASE_USER/.local/bin/json-tui $BASE_HOME/.local/bin/json-tui
# ↓なぜか要る
ENV USER=$BASE_USER
RUN bash /tmp/main1.sh
ENV PATH="$BASE_HOME/.local/bin:$BASE_HOME/.cargo/bin:$PATH"


FROM homebrew/brew AS base_brew
# uid=1000, user=linuxbrew
ARG BASE_USER
ENV LANG=C.utf-8
ENV __is_vm=1
COPY . /tmp/
COPY --from=base_ubuntu22 /home/$BASE_USER/.cargo /home/linuxbrew/.cargo
COPY --from=base_ubuntu22 /home/$BASE_USER/.local/bin/doxygen /home/linuxbrew/.local/bin/doxygen
COPY --from=base_ubuntu22 /home/$BASE_USER/.local/bin/json-tui /home/linuxbrew/.local/bin/json-tui
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
ENV LANG=C.utf-8
ENV __is_vm=1
COPY . /tmp/
RUN apt-get update && \
    apt-get -qqy install sudo curl xz-utils && \
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
    chezmoi init --apply na-trium-144
