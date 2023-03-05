{ pkgs, ... }:

let
  inherit (pkgs) emacs;
in
{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./config;
    emacsPackage = pkgs.emacs28NativeComp;
  };

  # LSPs
  home.packages = with pkgs; [
    nodePackages.prettier
    nodePackages.pyright
  ];
}
