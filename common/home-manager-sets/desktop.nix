{ self }:
let
  inherit (self);
  inherit (self.common) home-manager-modules;
  inherit (self.common.home-manager-module-sets) cli;
in
cli
++ (with home-manager-modules; [ desktop-packages dircolors /*doom-emacs*/ firefox ])
