{ lib, inputs, nixpkgs, home-manager, user, doom-emacs, ... }:

let
	system = "x86_64-linux";

	pkgs = import nixpkgs {
		inherit system;
		config.allowUnfree = true;
	};

	lib = nixpkgs.lib;

in
{
	home-desktop = lib.nixosSystem {
		inherit system;
		specialArgs = { inherit inputs user; };
		modules = [
			./home-desktop

			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				home-manager.extraSpecialArgs = {inherit user doom-emacs;};
				home-manager.users.${user} = {
					imports = [(import ./home-desktop/home.nix)];
				};
			}
		];
	};
}
