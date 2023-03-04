{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    coc.settings = {
      tabstop = 2;
      shiftwidth = 2;
      languageserver = {
        nix = {
          command = "rnix-lsp";
          filetypes = [ "nix" ];
        };
      };
    };
  };
}
