{ self }:
let inherit (self.common) home-manager-modules;
in with home-manager-modules; [
  alacritty
  fish
  git
  man
  neovim
  starship
  tmux
]
