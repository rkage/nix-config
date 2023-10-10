{
  description = "NixOS systems and tools";

  inputs = {
    # Primary nixpkgs repository is pinned to the latest release. Updating
    # this will change all system packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # Configure the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eza = {
      url = "github:eza-community/eza";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    overlays = [
      inputs.eza-overlay.overlay
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };
  in {
    nixosConfigurations.vm-aarch64 = mkSystem "vm-aarch64" {
      system = "aarch64-linux";
      user   = "nick";
    };
  };
}
