{ self, pkgs }:
let
  inherit (self) inputs;
  inherit (pkgs) lib;
in
pkgs.vimUtils.buildVimPluginFrom2Nix {
  pname = "nvim-treesitter-playground";
  version = "latest";
  src = inputs.nvim-treesitter-playground;

  meta = with lib; {
    description = "Treesitter playground integrated into Neovim ";
    homepage = "https://github.com/nvim-treesitter/playground";
    license = licenses.apsl20;
  };
}
