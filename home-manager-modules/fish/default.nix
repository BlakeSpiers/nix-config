{ config, pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = "
        set -x EDITOR nvim
        starship init fish | source
        direnv hook fish | source
            ";
  };
}
