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
      vim-fugitive
      #LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
    ];

    extraPackages = with pkgs; [
      tree-sitter
      git
      lua-language-server
    ];
  };

  xdg.configFile.nvim = {
    source = ./lua-files;
    recursive = true;
  };
}
