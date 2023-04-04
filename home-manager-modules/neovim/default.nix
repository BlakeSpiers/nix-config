{ config, pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
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
    plugins = [

    ];
  };
}
