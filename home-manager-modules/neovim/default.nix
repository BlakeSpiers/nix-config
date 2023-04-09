{ config, pkgs, lib, ... }: {

  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      rose-pine
      nvim-treesitter.withAllGrammars
      nvim-treesitter-playground
      undotree
    ];

    extraPackages = with pkgs; [
      tree-sitter
    ];
  };

  xdg.configFile.nvim = {
    source = ./lua-files;
    recursive = true;
  };
}
