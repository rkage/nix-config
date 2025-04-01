{ inputs, ... }:
{
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  nvchad-packages = final: _prev: {
    nvchad = import inputs.nvchad4nix.packages {
      system = final.system;
    };
  };
}
