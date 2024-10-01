#!/usr/bin/env bash
set -euo pipefail

container_packages=(
    ansible
    bash
    bind
    diffutils
    direnv
    jq
    gettext
    git
    gitk
    git
    info
    iproute
    iputils
    make
    man
    netcat
    net-tools
    nmap
    openssl
    pass
    traceroute
    unzip
    vim
    wget
    which
)

distrobox_packages=(
   gnupg2
   pinentry
   zip
)

distrobox_dependencies=(
    bc
    bzip2
    chpasswd
    curl
    diff
    find
    findmnt
    gpg
    hostname
    less
    lsof
    man
    mount
    passwd
    pigz
    pinentry
    ping
    ps
    rsync
    script
    ssh
    sudo
    time
    tree
    umount
    unzip
    useradd
    wc
    wget
    xauth
    zip
)

all_packages=("${container_packages[@]}" "${distrobox_packages[@]}")

required_man_packages=(
    authselect
    authselect
    ca
    cracklib
    crypto
    expat
    filesystem
    file
    ima
    keyutils
    libarchive
    libpwquality
    libsemanage
    openldap
    pcre2
    shadow-utils
)

# Upgrade built-in packages
dnf update -y
dnf upgrade -y

# Reinstall some packages to get man pages back
dnf install -y man
dnf reinstall -y "${required_man_packages[@]}"

# Install missing packages
dnf install -y "${all_packages[@]}"

# Check for mising dependencies
dependency_missing=false
for dependency in "${distrobox_dependencies[@]}"; do
    if ! command -v "${dependency}" > /dev/null; then
        echo "Error: missing dependency: $dependency"
        dependency_missing=true
    fi
done

if [ "$dependency_missing" = true ]; then
    exit 1;
fi

# Install Starship
export nerd_font_name=IntoneMono
export github_api=https://api.github.com
export repo=ryanoasis/nerd-fonts
curl -sS https://starship.rs/install.sh | sh -s -- -y
 
# Chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"

# Trivy
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.48.3

# Cleanup packages
dnf clean all

