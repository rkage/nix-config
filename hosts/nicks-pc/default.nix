{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    ../shared/gigabyte-b550-fix.nix

    ./hardware-configuration.nix

    ../shared
    ../shared/users/nick

    ../shared/bash.nix
    ../shared/quietboot.nix
    ../shared/greetd.nix
    ../shared/pipewire.nix
    ../shared/printing.nix
  ];

  networking = {
    hostName = "nicks-pc";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = ["amd_pstate=active" "acpi_enforce_resources=lax"];
  };

  services.logind.extraConfig = ''
    IdleAction=suspend
    IdleActionSec=3600
  '';

  programs = {
    dconf.enable = true;
  };

  hardware.i2c.enable = true;
  services.hardware.openrgb.enable = true;
  services.udev.extraRules = builtins.readFile "${pkgs.openrgb}/lib/udev/rules.d/60-openrgb.rules";
  hardware.graphics.enable = true;

  system.stateVersion = "23.05";
}
