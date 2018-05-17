{ ... }:
{ pkgs, ... }:
# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
let install = [ pkgs.nix-repl
                pkgs.gitAndTools.gitFull
                pkgs.vimHugeX
                pkgs.screen
                pkgs.tmux
                pkgs.scrot

                pkgs.htop
                pkgs.mosh
                pkgs.autossh
                pkgs.acpi
                pkgs.proxychains
                pkgs.nginx
                pkgs.httpie
                pkgs.iptables
                pkgs.w3m
                pkgs.lynx
                pkgs.ncurses
                pkgs.sshfsFuse
                pkgs.wget
                pkgs.curl

                pkgs.unrar
                pkgs.unzip
                pkgs.p7zip

                pkgs.nettools
                pkgs.vpnc
                pkgs.linuxConsoleTools
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

                pkgs.mtools
                pkgs.cdrkit
                pkgs.syslinux
                pkgs.qemu

                pkgs.wine
                
                pkgs.texlive.combined.scheme-full
                
              ];
in
{ environment.systemPackages = install; }
