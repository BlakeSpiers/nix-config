{ pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ../../modules/nix
      ../../modules/sudo
      ../../modules/fonts
      ../../modules/time
      ../../modules/gnome
      ../../modules/nvidia
      ../../modules/pipewire
      ../../users/blake.nix
    ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "22.11";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.utf8";

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
