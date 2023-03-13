{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-command fish
    '';
  };
}
