{ self }:
let
  inherit (self.common) home-manager-modules;
  inherit (self.inputs) nix-doom-emacs;
in
[ nix-doom-emacs.hmModule home-manager-modules.doom-emacs ]
