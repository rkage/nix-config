{
  description = "NixOS systems and tools";

  inputs = {
    # Primary nixpkgs repository is pinned to the latest release. Updating
    # this will change all system packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Configure the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @inputs: let

    overlays = [
    ];
    
    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
    nixosConfigurations.vm-aarch64 = mkSystem "vm-aarch64" {
      system = "aarch64-linux";
      user   = "nick";
    };
  };
}
