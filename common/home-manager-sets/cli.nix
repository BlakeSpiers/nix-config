{ self }:
let inherit (self.common) home-manager-modules;
in with home-manager-modules; [
  alacritty
  direnv
  fish
  git
  man
  neovim
  starship
  tmux
]
