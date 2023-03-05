{ config, lib, ... }: {
  networking = {
    hostName = "blake-desktop"; # Define your hostname.
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
