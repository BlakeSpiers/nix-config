{ pkgs, ... }:
let
  inherit (pkgs) emacs28NativeComp;
in
{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./config;
    emacsPackage = emacs28NativeComp;
  };

  # LSPs
  home.packages = with pkgs; [
    nodePackages.prettier
    nodePackages.pyright
  ];
}
