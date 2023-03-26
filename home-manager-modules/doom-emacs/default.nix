{ pkgs, osConfig, ... }:
let
  inherit (pkgs) emacs28NativeComp;
  inherit (osConfig.flake.inputs) nix-doom-emacs;
in
{
  imports = [
    nix-doom-emacs.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./config;
    emacsPackage = emacs28NativeComp;
    extraPackages = with pkgs; [
      fd
      ripgrep
    ];
  };

  # LSPs
  home.packages = with pkgs; [
    nodePackages.prettier
    nodePackages.pyright
  ];
}
