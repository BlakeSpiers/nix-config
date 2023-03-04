{ pkgs, ... }: {
  imports = [
    ../../home-manager-modules/alacritty
    ../../home-manager-modules/fish
    ../../home-manager-modules/git
    ../../home-manager-modules/neovim
    ../../home-manager-modules/tmux
    ../../home-manager-modules/firefox
    ../../home-manager-modules/starship
  ];

  home = {
    packages = with pkgs; [
      ripgrep
      fd
      slack
      spotify
    ];

    stateVersion = "22.11";
  };
}
