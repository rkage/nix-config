{ config, pkgs, lib, currentSystem, currentSystemName, ... }:

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
      substituters = ["https://nmcfaul-nixos-config.cachix.org"];
      trusted-public-keys = ["nmcfaul-nixos-config.cachix.org-1:PVJxAC60dMCtjhAg4C1/0VVM55H7g3UYo37B6SYv7uQ="];
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

  # Setup greetd and tuigreet for simplified login screen
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  services.greetd = {
   enable = true;
   settings = rec {
     initial_session = {
       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.sway}/bin/sway";
       user = "nick";
     };
     default_session = initial_session;
   };
  };
  security.pam.services.greetd.enableGnomeKeyring = true;  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    glib
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
