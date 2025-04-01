{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.gigabyte-b550

    ./hardware-configuration.nix

    ../common
    ../common/optional/_1password.nix
    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix

    ../users/nick
  ];

  networking.hostName = "Nicks-PC";
  networking.useDHCP = false;
  systemd.network.enable = true;
  systemd.network.networks."50-enp5s0" = {
    matchConfig.Name = "enp5s0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    login.enableGnomeKeyring = true;
    hyprlock = { };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "24.11";
}
