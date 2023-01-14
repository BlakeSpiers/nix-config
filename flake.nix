{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs = {
      url = github:nix-community/nix-doom-emacs;
    };
  };

  outputs = { self, ... }:
    let
      user = "blake";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit self user;
        }
      );

      formatter.x86_64-linux = self.inputs.nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
