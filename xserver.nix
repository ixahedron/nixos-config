{ touchpad ? "tapPad",  kbLayout ? "lv,de,ru", kbOptions ? "grp:caps_toggle", ... }:
{ pkgs, ... }:

let

  mkSynaptics = x:
    if x == "tapPad" then {
      enable = true;
      minSpeed = "1.0";
      maxSpeed = "2.0";
      tapButtons = true;
      twoFingerScroll = true;
      horizontalScroll = true;
      palmDetect = false;
      buttonsMap = [1 3 2];
      additionalOptions = ''
        Option "SoftButtonAreas" "60% 0 72% 0 40% 59% 72% 0"
        Option "AccelerationProfile" "2"
        Option "ConstantDeceleration" "4"
      '';
    } else {
      enable = true;
      tapButtons = false;
      twoFingerScroll = true;
      horizontalScroll = true;
      palmDetect = true;
    };


  blender = pkgs.stdenv.lib.overrideDerivation pkgs.blender (oldAttrs: {
	  cudaSupport = true;
  });

  utils = [ pkgs.firefoxWrapper
            pkgs.chromium
            pkgs.skype
            pkgs.discord
            pkgs.tdesktop

            pkgs.pulseaudioFull
            pkgs.pavucontrol

            pkgs.mplayer
            pkgs.ffmpeg
            pkgs.vlc

            pkgs.rxvt-unicode
            pkgs.urxvt_perls

            pkgs.haskellPackages.xmobar
            pkgs.dmenu

            pkgs.feh
            pkgs.blender
            pkgs.inkscape
            pkgs.gimp

            # pkgs.autocutsel
            pkgs.clipit

            pkgs.zathura
            # pkgs.fbreader
            # pkgs.calibre

            pkgs.xclip
            pkgs.xorg.xev
            pkgs.xorg.xhost

            pkgs.glibc
            pkgs.xorg.libXinerama
            pkgs.xorg.libXcursor
            pkgs.xorg.libXrandr
            pkgs.xorg.libXi
            pkgs.xorg.libX11
            pkgs.libGL
            pkgs.libpulseaudio
            pkgs.libpng
            pkgs.libpng12
            pkgs.alsaLib

            pkgs.wireshark-cli

            pkgs.qt5.qtbase
            pkgs.qt5.qtquickcontrols
            pkgs.qt5.qtgraphicaleffects

          ];

  fonts = with pkgs; [
            cantarell_fonts
            corefonts
            dejavu_fonts
            dina-font
            dosemu_fonts
            freefont_ttf
            gyre-fonts
            open-sans
            proggyfonts
            terminus_font
            ubuntu_font_family
          ];

  additionalKeybinds = pkgs.writeText "xkb-layout" ''
      keycode 223 = at
    '';

in
{
  # Use wicd
  imports = [ ./xserver/wicd.nix ./xserver/unfree.nix ];
  # Use pulse
  hardware.pulseaudio.enable = true;
  services.xserver = {
    enable = true;
    layout = kbLayout;
    xkbOptions = kbOptions;
    synaptics = mkSynaptics touchpad;

    displayManager = {
      defaultSession = "none+xmonad";
      sessionCommands = "${pkgs.xorg.xsetroot}/bin/xsetroot -solid black; ${pkgs.xorg.xmodmap}/bin/xmodmap ${additionalKeybinds}";
      sddm = {
        enable = true;
        autoNumlock = true;
        autoLogin = {
          enable = false;
          user = "ix";
        };
        theme = "chili";
      };

    };
  };

  fonts = {
    enableFontDir = true;
    enableDefaultFonts = true;

    fonts = fonts;

    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans" "Open Sans" "Liberation Sans" ];
        monospace = [ "DejaVu Sans Mono" ];
      };
    };
  };

  environment.systemPackages =
    let chili = pkgs.callPackage ./xserver/sddm-theme-chili.nix {}; in builtins.concatLists [ utils [chili] ];
}
