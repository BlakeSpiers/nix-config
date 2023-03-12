{ self }:
let
  inherit (self) inputs;

  # Package Sets
  inherit (self.inputs) stable unstable;

  # Extra modules
  # inherit (self.inputs) microvm nixos-generators nixos-hardware nixos-wsl;

  inherit (self.common.system) stable-system unstable-system;

  inherit (self.common.package-sets)
    x86_64-linux-stable x86_64-linux-unstable aarch64-linux-stable
    aarch64-linux-unstable;

in
{
  home-desktop =
    let
      inherit (x86_64-linux-unstable) system identifier pkgs;
      base = self.common.modules.${identifier};
      modules = base ++ [ ../hosts/home-desktop ];
    in
    unstable-system { inherit system pkgs modules; };
}
