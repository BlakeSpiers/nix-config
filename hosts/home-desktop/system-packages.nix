{ config, pkgs, ... }:
let inherit (config.nur.repos.kira-bruneau) pokemmo-installer;
in {
  environment.systemPackages = with pkgs; [
    # CLI
    curl
    neovim
    wget
  ];
}
