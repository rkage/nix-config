{
  config,
  lib,
  pkgs,
  ...
}: let
  common-options = ["noatime" "compress-force=zstd" "commit=120" "space_cache=v2" "ssd" "discard=async" "autodefrag"];
in {
  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        # "i2c-dev"
        # "i2c-piix4"
      ];
      kernelModules = ["kvm-amd"];
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/nvme0n1p2";
    fsType = "btrfs";
    options = ["subvol=root"] ++ common-options;
  };

  fileSystems."/home" = {
    device = "/dev/nvme0n1p2";
    fsType = "btrfs";
    options = ["subvol=home"] ++ common-options;
  };

  fileSystems."/var/tmp" = {
    device = "/dev/nvme0n1p2";
    fsType = "btrfs";
    options = ["subvol=tmp" "nodev" "nosuid" "noexec"] ++ common-options;
  };

  fileSystems."/nix" = {
    device = "/dev/nvme0n1p2";
    fsType = "btrfs";
    options = ["subvol=nix"] ++ common-options;
  };

  fileSystems."/var/log" = {
    device = "/dev/nvme0n1p2";
    fsType = "btrfs";
    options = ["subvol=log" "nodev" "nosuid" "noexec"] ++ common-options;
  };

  fileSystems."/.snapshots" = {
    device = "/dev/nvme0n1p2";
    fsType = "btrfs";
    options = ["subvol=snapshots"] ++ common-options;
  };

  fileSystems."/swap" = {
    device = "/dev/nvme0n1p2";
    fsType = "btrfs";
    options = ["subvol=swap" "noatime"];
  };

  fileSystems."/btrfs" = {
    device = "/dev/nvme0n1p2";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A5B8-A7DA";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [{device = "/swap/swapfile";}];

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
}
