ARG base_tag=40
ARG base_image=registry.fedoraproject.org/fedora-toolbox
FROM ${base_image}:${base_tag}

RUN dnf update -y && dnf upgrade -y

# Reinstall some packages to get man pages back
RUN dnf install -y man

RUN dnf reinstall -y    \
    authselect          \
    authselect-libs     \
    ca-certificates     \
    cracklib-runtime    \
    crypto-policies     \
    expat               \
    filesystem          \
    file-libs           \
    ima-evm-utils       \
    keyutils-libs       \
    libarchive          \
    libpwquality        \
    libsemanage         \
    openldap            \
    pcre2-syntax        \
    shadow-utils

RUN dnf install -y  \
    ansible         \
    bash-completion \
    bind-utils      \
    jq              \
    git             \
    gitk            \
    git-lfs         \
    gnupg2          \
    info            \
    iproute         \
    iputils         \
    make            \
    man             \
    netcat          \
    net-tools       \
    nmap            \
    openssl         \
    traceroute      \
    unzip           \
    vim-enhanced    \
    wget            \
    which

COPY container_bin/* /usr/local/bin
RUN chmod +x /usr/local/bin/*

RUN ln -s /usr/bin/host-spawn-no-pty    /usr/local/bin/com.vscodium.codium  && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/distrobox            && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/fwupdmgr             && \
    ln -s /usr/bin/host-spawn-no-pty    /usr/local/bin/org.vim.Vim          && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/podman               && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/rpm-ostree           && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/systemctl            && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/tailscale

# starship
ARG nerd_font_name=IntoneMono
ARG github_api=https://api.github.com
ARG repo=ryanoasis/nerd-fonts
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

# chezmoi
RUN sh -c "$(curl -fsLS get.chezmoi.io)"

# trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.48.3

# cleanup
RUN dnf clean all
