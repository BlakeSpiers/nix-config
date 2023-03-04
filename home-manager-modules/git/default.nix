{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Blake Spiers";
    userEmail = "blakespiers93@gmail.com";
    extraConfig = {
      core.editor = "nvim";
    };
  };
}
