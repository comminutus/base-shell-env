# base-shell-env
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](https://www.gnu.org/licenses/agpl-3.0.html)
[![CI](https://github.com/comminutus/base-shell-env/actions/workflows/ci.yaml/badge.svg)](https://github.com/comminutus/base-shell-env/actions/workflows/ci.yaml)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/comminutus/base-shell-env)](https://github.com/comminutus/base-shell-env/releases/latest)

## Description
`base-shell-env` is a container image meant to serve as a base for other containers used with [Distrobox](https://github.com/89luca89/distrobox) and [Toolbox](https://github.com/containers/toolbox), but it can also be used a shell image directly.  It has a few goodies installed like [Starship](https://github.com/starship/starship) and [Chezmoi](https://github.com/twpayne/chezmoi).

## Features
- [Starship](https://github.com/starship/starship) installed.
- [Chezmoi](https://github.com/twpayne/chezmoi) installed.
- Some commands run on the host system so you don't have to flip between a `base-shell-env` shell and your host's shell:
  - `com.vscodium.codium`
  - `distrobox`
  - `fwupdmgr`
  - `org`
  - `podman`
  - `rpm`
  - `systemctl`


## Getting Started

### Prerequisites

You must have a container runtime installed, like [Podman](https://github.com/containers/podman)(preferred) or [Docker](https://github.com/docker-library/docker).

## Usage

Pull down the image and use it directly with Distrobox or Toolbox:
```
podman pull ghcr.io/comminutus/base-shell-env 
distrobox create -i comminutus/base-shell-env
distrobox enter base-shell-env
```

Or use it as the base for other images in a `Containerfile` or `Dockerfile` to create more shell images:
```
FROM ghcr.io/comminutus/base-shell-env:latest
...
```

## License

This project is licensed under the GNU Affero General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
