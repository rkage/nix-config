{
  description = "Home-Manager (dotfiles) and NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvchad4nix.url = "github:nix-community/nix4nvchad";
    nvchad4nix.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        "Nicks-PC" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/nicks-pc
          ];
        };
      };

      homeConfigurations = {
        "nick@Nicks-PC" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home-manager/home.nix
            ./home-manager/nixpkgs.nix
          ];
        };
      };
    };
}
