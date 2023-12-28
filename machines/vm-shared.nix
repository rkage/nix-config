{ config, pkgs, lib, currentSystem, currentSystemName, ... }:

let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop xdg-desktop-portal xdg-desktop-portal-gtk
      systemctl --user start xdg-desktop-portal xdg-desktop-portal-gtk
    '';
  };
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Nordic'
      '';
  };
in
{
  # Be careful updating this.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Remove unnecessary pre-installed packages
  environment.defaultPackages = [ ];
  services.xserver.desktopManager.xterm.enable = false;

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
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      # VMware, Parallels both only support this being 0 otherwise you see
      # "error switching console mode" on boot.
      systemd-boot.consoleMode = "0";
      efi.canTouchEfiVariables = true;
    };
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

  # setup windowing environment

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name  
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Setup greetd and tuigreet for simplified login screen
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;

  # Managed Fons, managed separately from other packages.
  fonts = {
    fontDir.enable = true;

    enableDefaultPackages = true;
    packages = with pkgs; [
      inter-ui
      iosevka
      noto-fonts
      nerdfonts
    ];
    fontconfig = {
      defaultFonts.monospace = [ "Noto Sans Mono" "Symbols Nerd Font Mono" ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dbus-sway-environment
    configure-gtk
    glib # gsettings
    nordic # gtk-theme
    cachix
    gnumake
    killall
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
