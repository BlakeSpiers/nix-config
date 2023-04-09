{ self, system, pkgs }: {
  vim-plugins = import ./vim-plugins { inherit self pkgs; };
}
