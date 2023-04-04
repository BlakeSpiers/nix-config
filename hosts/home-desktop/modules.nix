{ config, lib, pkgs, ... }: {
  imports =
    [
      ../../modules/nix
      ../../modules/sudo
      ../../modules/fish
      ../../modules/fonts
      ../../modules/openssh
      ../../modules/time
      ../../modules/gnome
      ../../modules/nvidia
      ../../modules/pipewire
    ];
}
