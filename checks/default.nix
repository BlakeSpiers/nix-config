{ self, system, ... }: {
  modules = [
    (import ./pre-commit.nix)
  ];
}
