{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      firefox
      tmux
      ripgrep
      fd
      #emacs
      spotify
      starship
    ];

    stateVersion = "22.05";
  };

  programs = {
    neovim = {
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

    git = {
      enable = true;
      userName = "Blake Spiers";
      userEmail = "blakespiers93@gmail.com";
      extraConfig = {
        core.editor = "nvim";
      };
    };

    alacritty = {
      enable = true;
      settings = {
        env = [ "EDITOR=nvim" ];

        shell.program = "${pkgs.fish}/bin/fish";

        window = {
          startup_mode = "Fullscreen";
        };

        font = {
          normal.family = "Hack Nerd Font Mono";
          bold.family = "Hack Nerd Font Mono";
          italic.family = "Hack Nerd Font Mono";
          size = 8.0;
          offset = {
            x = 0;
            y = 0;
          };
          glyph_offset = {
            x = 0;
            y = 0;
          };
        };
      };
    };

    fish = {
      enable = true;
      interactiveShellInit = "
				starship init fish | source
			";
    };
  };
}
