{ self, user, ... }:

let
  system = "x86_64-linux";

  pkgs = import self.inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = self.inputs.nixpkgs.lib;

  home-manager = self.inputs.home-manager;

  doom-emacs = self.inputs.doom-emacs;

  # This is required for any system needing to reference the flake itself from
  # within the nixosSystem config. It will be available as an argument to the 
  # config as "flake" if used as defined below
  # referenceSelf = { config._modules.args.flake = self; };
in
{
  home-desktop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit pkgs user; };
    modules = [
      ./home-desktop

      #referenceSelf

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit pkgs user; };
        home-manager.users.${user} = { ... }: {
          imports = [ (import ./home-desktop/home.nix) doom-emacs.hmModule ];
          programs.doom-emacs = {
            enable = true;
            doomPrivateDir = ../doom.d;
          };
        };
      }
    ];
  };
}
