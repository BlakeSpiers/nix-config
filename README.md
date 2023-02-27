# nix-config

To update flake dependencies:
sudo nix flake update && 

To rebuild the flake for home-desktop:
sudo nixos-rebuild switch --flake .#home-desktop

To do both:
sudo nix flake update && sudo nixos-rebuild switch --flake .#home-desktop
