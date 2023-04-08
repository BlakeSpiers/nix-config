{ config, pkgs, lib, ... }: {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      rose-pine
      nvim-treesitter.withAllGrammars
    ];
  };

  xdg.configFile.nvim = {
    source = ./lua-files;
    recursive = true;
  };
}
