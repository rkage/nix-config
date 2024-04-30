{
  config,
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

    ../shared/quietboot.nix
    ../shared/greetd.nix
    ../shared/pipewire.nix
  ];

  networking = {
    hostName = "nicks-pc";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  # systemd.sleep.extraConfig = ''
  #   AllowSuspend=yes
  #   AllowHibernation=no
  #   AllowSuspendThenHibernate=no
  # '';

  programs = {
    dconf.enable = true;
  };

  services.hardware.openrgb.enable = true;
  services.udev.extraRules = builtins.readFile "${pkgs.openrgb}/lib/udev/rules.d/60-openrgb.rules";
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vulkan-validation-layers
    ];
  };

  system.stateVersion = "23.05";
}
