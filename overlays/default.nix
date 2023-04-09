{ self }:
let
  inherit (self) outputs;
in
{
  vimPlugins = _final: prev: {
    vimPlugins = prev.vimPlugins // outputs.packages.${prev.system}.vim-plugins;
  };
}
