{ self }:
let
  inherit (self.common) home-manager-modules;
in
[ home-manager-modules.doom-emacs ]
