{ config, lib, pkgs, ... }: {
  imports =
    [
      ../../modules/nix
      ../../modules/sudo
      ../../modules/fonts
      ../../modules/time
      ../../modules/gnome
      ../../modules/nvidia
      ../../modules/pipewire
    ];
}
