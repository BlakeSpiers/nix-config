{ self, ... }:

let
  system = "x86_64-linux";

  pkgs = import self.inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = self.inputs.nixpkgs.lib;

  home-manager = self.inputs.home-manager;

  nix-doom-emacs = self.inputs.nix-doom-emacs;

in
{
  home-desktop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit pkgs; };
    modules = [
      ./home-desktop

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit pkgs; };
        home-manager.users.blake = {
          imports = [
            ./home-desktop/home.nix
            ../home-manager-modules/doom
            nix-doom-emacs.hmModule
          ];
        };
      }
    ];
  };
}
