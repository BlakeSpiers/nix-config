# nix-config

To update flake dependencies:
nix flake update

To rebuild the flake for home-desktop:
nixos-rebuild switch --flake .#home-desktop --use-remote-sudo

To do both:
nix flake update && nixos-rebuild switch --flake .#home-desktop --use-remote-sudo
