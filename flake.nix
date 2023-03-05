{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs = {
      url = github:nix-community/nix-doom-emacs;
    };

    # Adds configurable pre-commit options to our flake :)
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = { self, ... }: {
    nixosConfigurations = (
      import ./hosts {
        inherit self;
      }
    );

    formatter.x86_64-linux = self.inputs.nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
