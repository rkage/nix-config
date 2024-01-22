{ config, pkgs, lib, currentSystem, currentSystemName, ... }:

{
  # Be careful updating this.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Remove unnecessary pre-installed packages
  environment.defaultPackages = [ ];

  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';

    # This is my public binary cache. It can be keept or removed/changed.
    # Its typically safe to use a binary cache since the data inside is checksummed.
    settings = {
      substituters = [ "https://nmcfaul-nixos-config.cachix.org" ];
      trusted-public-keys = [ "nmcfaul-nixos-config.cachix.org-1:PVJxAC60dMCtjhAg4C1/0VVM55H7g3UYo37B6SYv7uQ=" ];
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    tmp.cleanOnBoot = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      # VMware, Parallels both only support this being 0 otherwise you see
      # "error switching console mode" on boot.
      systemd-boot.consoleMode = "0";
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail" ];
  };

  # Define your hostname.
  networking.hostName = "dev";

  # Set your time zone.
  time.timeZone = "Canada/Eastern";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Don't require password for sudo
  security.sudo.wheelNeedsPassword = false;

  # Virtualization settings
  virtualisation.docker.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Setup windowing environment, using X11 until better support is available (i.e. copy/paste)
  services.xserver = {
    enable = true;
    layout = "us";
    dpi = 96;
    resolutions = [
      { x = 1920; y = 1080; }
    ];

    desktopManager = {
      xterm.enable = false;
      wallpaper.mode = "fill";
    };

    displayManager = {
      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 250 35
      '';
    };

    windowManager = {
      i3.enable = true;
    };
  };

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name  
  # services.dbus.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   config.common.default = "*";
  #   wlr.enable = false;
  #   # gtk portal needed to make gtk apps happy
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };
  #
  # environment.variables = {
  #   WLR_NO_HARDWARE_CURSORS = "1";
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;

  # Managed Fonts, managed separately from other packages.
  fonts = {
    fontDir.enable = true;

    enableDefaultPackages = true;
    packages = with pkgs; [
      inter-ui
      iosevka
      noto-fonts
      jetbrains-mono
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
    fontconfig = {
      defaultFonts.monospace = [ "Noto Sans Mono" "Symbols Nerd Font Mono" ];
    };
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    glib # gsettings
    nordic # gtk-theme
    cachix
    gnumake
    killall
    xclip
    (writeShellScriptBin "xrandr-auto" ''
      xrandr --output Virtual-1 --auto
    '')
  ] ++ lib.optionals (currentSystemName == "vm-aarch64") [
    gtkmm3
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "no";

  # Disable the firewall since we're in a VM and we want to make it
  # easy to visit stuff in here. We only use NAT networking anyways.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
