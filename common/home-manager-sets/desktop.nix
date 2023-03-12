{ self }:
let
  inherit (self);
  inherit (self.common) home-manager-modules;
  inherit (self.common.home-manager-module-sets) cli doom-emacs;
in
cli
++ doom-emacs
++ (with home-manager-modules; [ desktop-packages dircolors firefox ])
