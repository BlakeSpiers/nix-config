{ self, pkgs }: {
  nvim-treesitter-playground = import ./nvim-treesitter-playground.nix { inherit self pkgs; };
}
