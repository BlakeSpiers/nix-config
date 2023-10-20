# nix-config

To update flake dependencies:
`nix flake update`

To rebuild the flake for home-desktop:
`nixos-rebuild switch --flake .#home-desktop --use-remote-sudo`

To do both:
`nix flake update && nixos-rebuild switch --flake .#home-desktop --use-remote-sudo`

## Fresh Install
Run:
`nixos-rebuild switch --flake github:blakespiers/nix-config#HOST --use-remote-sudo`

If you encounter `systemd-boot not installed in ESP.`, run:
`sudo bootctl install`

Reboot and repeat the rebuild step.
