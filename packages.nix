{ ... }:
{ pkgs, ... }:
# List packages installed in system profile. To search by name, run:
# $ nix search wget
let
  install = with pkgs; [
    gitFull
    git-absorb
    vim-full
    screen
    tmux
    escrotum
    direnv

    htop
    mosh
    autossh
    acpi
    #proxychains
    httpie
    iptables
    w3m
    lynx
    ncurses
    sshfs-fuse
    wget
    curl

    unrar
    unzip
    zip

    nettools
    wirelesstools
    vpnc
    linuxConsoleTools
    gnumake
    binutils-unwrapped
    psmisc
    lm_sensors
    # kexectools
    figlet
    tcpdump
    strace
    traceroute
    nmap
    openssl

    gnupg
    pinentry-all

    gcc

    ghc
    zlib

    # nodejs-14_x

    mtools
    cdrkit
    syslinux
    qemu
    pciutils
    clinfo
    patchelf

    # texlive.combined.scheme-full

    vscode.fhs

  ];
in {

  environment.systemPackages = install;
}
