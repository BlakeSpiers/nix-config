{ config, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "-l" "-c" "tmux attach || tmux" ];
      };

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

}
