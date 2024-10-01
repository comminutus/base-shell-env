FROM fedora-toolbox:40

WORKDIR "$HOME"

COPY install-packages.bash .
COPY container_bin/* /usr/local/bin

RUN ln -s /usr/bin/host-spawn           /usr/local/bin/dconf                && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/distrobox            && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/fwupdmgr             && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/gsettings            && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/journalctl           && \
    ln -s /usr/bin/host-spawn-no-pty    /usr/local/bin/org.gnome.Meld       && \
    ln -s /usr/bin/host-spawn-no-pty    /usr/local/bin/org.vim.Vim          && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/ostree               && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/podman               && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/rpm-ostree           && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/systemctl            && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/tailscale            && \
    ln -s /usr/bin/host-spawn           /usr/local/bin/xdg-open             && \
    ./install-packages.bash                                                 && \
    rm ./install-packages.bash
