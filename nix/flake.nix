{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, darwin }: {
    darwinConfigurations."sbpltt6cllvdl" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";

      modules = [
        home-manager.darwinModules.home-manager
        ./hosts/sbpltt6cllvdl/default.nix
      ];
    };
  };
}
