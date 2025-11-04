#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

dnf5 -y remove firefox

dnf5 -y install mpv yt-dlp

dnf5 config-manager setopt google-chrome.enabled=1
dnf5 -y install google-chrome-stable
dnf5 config-manager setopt google-chrome.enabled=0

dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf5 -y swap fmpeg-free ffmpeg --allowerasing
dnf5 -y swap mesa-va-drivers mesa-va-drivers-freeworld
dnf5 -y swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
dnf5 -y swap mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
dnf5 -y swap mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686

dnf5 -y install steam
dnf5 -y remove rpmfusion-free-release rpmfusion-nonfree-release

dnf5 -y install https://repo.protonvpn.com/fedora-$(rpm -E %fedora)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.3-1.noarch.rpm
dnf5 -y install proton-vpn-gnome-desktop || true
dnf5 -y remove proton-stable-release

#### Example for enabling a System Unit File

# systemctl enable podman.socket
