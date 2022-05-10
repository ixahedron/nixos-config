{ ... }:
{ pkgs, ... }:
# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
let install = [ pkgs.gitAndTools.gitFull
                pkgs.vimHugeX
                pkgs.screen
                pkgs.tmux
                pkgs.scrot

                pkgs.htop
                pkgs.mosh
                pkgs.autossh
                pkgs.acpi
                #pkgs.proxychains
                pkgs.nginx
                pkgs.httpie
                pkgs.iptables
                pkgs.w3m
                pkgs.lynx
                pkgs.ncurses
                pkgs.sshfs-fuse
                pkgs.wget
                pkgs.curl

                pkgs.unrar
                pkgs.unzip

                pkgs.nettools
                pkgs.wirelesstools
                pkgs.vpnc
                pkgs.linuxConsoleTools
                pkgs.gnumake
                pkgs.binutils-unwrapped
                pkgs.psmisc
                pkgs.lm_sensors
                pkgs.kexectools
                pkgs.figlet
                pkgs.gnupg
                pkgs.tcpdump
                pkgs.strace
                pkgs.traceroute
                pkgs.nmap
                pkgs.openssl

                pkgs.gcc

                pkgs.ghc
                pkgs.stack
                pkgs.zlib
                pkgs.hlint
                pkgs.stylish-haskell

                # pkgs.nodejs-14_x

                pkgs.mtools
                pkgs.cdrkit
                pkgs.syslinux
                pkgs.qemu
                pkgs.pciutils
                pkgs.clinfo
                pkgs.patchelf

                # pkgs.wineWowPackages.staging
                # pkgs.wine-devel
                #pkgs.wine

                #pkgs.texlive.combined.scheme-full

              ];
in {

#  imports =
#    [
#      ./packages/wine-devel.nix
#    ];

  environment.systemPackages = install;
}
