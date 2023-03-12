{ config, pkgs, lib, flake, ... }:

let
  inherit (flake) common;
  inherit (flake.common.home-manager-module-sets) linux-desktop;
  inherit (flake.lib) merge-user-config;

  blake = common.users.blake {
    inherit config pkgs;
    modules = linux-desktop;
  };

  merged = merge-user-config { users = [ blake ]; };

in
{
  inherit flake;
  inherit (merged) users home-manager;

  imports =
    [ ../../options/flake ./hardware-configuration.nix ./modules.nix ./system-packages.nix ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.utf8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  networking = {
    hostName = "blake-desktop"; # Define your hostname.
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  system.stateVersion = "22.11";
}
