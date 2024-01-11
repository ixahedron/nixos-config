{ ... }:
{ pkgs, ... }:
# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
let
  install = with pkgs; [
    gitAndTools.gitFull
    vimHugeX
    screen
    tmux
    escrotum

    htop
    mosh
    autossh
    acpi
    #proxychains
    nginx
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

    nettools
    wirelesstools
    vpnc
    linuxConsoleTools
    gnumake
    binutils-unwrapped
    psmisc
    lm_sensors
    kexectools
    figlet
    gnupg
    tcpdump
    strace
    traceroute
    nmap
    openssl

    gcc

    ghc
    stack
    zlib
    hlint
    stylish-haskell

    # nodejs-14_x

    mtools
    cdrkit
    syslinux
    qemu
    pciutils
    clinfo
    patchelf

    # wineWowPackages.staging
    # wine-devel
    # wine

    # texlive.combined.scheme-full

  ];
in {

#  imports =
#    [
#      ./packages/wine-devel.nix
#    ];

  environment.systemPackages = install;
}
