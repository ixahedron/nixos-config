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

            pkgs.rxvt_unicode_with-plugins
            pkgs.urxvt_perls

            pkgs.haskellPackages.xmobar
            pkgs.dmenu

            pkgs.feh
            pkgs.blender
            pkgs.inkscape
            pkgs.gimp

            pkgs.autocutsel
            pkgs.clipit

            pkgs.zathura
            pkgs.mcomix
            # pkgs.fbreader
            # pkgs.calibre

            pkgs.redshift

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
          ];

  fonts = with pkgs; [
            cantarell_fonts
            corefonts
            dejavu_fonts
            dina-font
            dosemu_fonts
            freefont_ttf
            gyre-fonts
            #lohit-fonts
            open-sans
            proggyfonts
            terminus_font
            ubuntu_font_family
            emojione
            joypixels
            twitter-color-emoji
          ];

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
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      autoLogin = {
        enable = false;
        user = "ix";
      };
#      theme = pkgs.fetchurl {
#        url    = "https://store.kde.org/p/1232289/startdownload?file_id=1525176206&file_name=nixos-noblur.tar.gz&file_type=application/x-gzip&file_size=5289842";
#      };
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = fonts;
  };

  environment.systemPackages = builtins.concatLists [ utils ];
}
