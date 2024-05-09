{
  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
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

  fileSystems = let
    common-options = ["noatime" "compress-force=zstd" "commit=120" "space_cache=v2" "ssd" "discard=async" "autodefrag"];
  in {
    "/" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = ["subvol=root"] ++ common-options;
    };

    "/home" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = ["subvol=home"] ++ common-options;
    };

    "/var/tmp" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = ["subvol=tmp" "nodev" "nosuid" "noexec"] ++ common-options;
    };

    "/nix" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = ["subvol=nix"] ++ common-options;
    };

    "/var/log" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = ["subvol=log" "nodev" "nosuid" "noexec"] ++ common-options;
    };

    "/.snapshots" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = ["subvol=snapshots"] ++ common-options;
    };

    "/swap" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = ["subvol=swap" "noatime"];
    };

    "/btrfs" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/A5B8-A7DA";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  swapDevices = [{device = "/swap/swapfile";}];

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
}
