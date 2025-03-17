{
  # TODO: transfer config to nix?
  extraConfigLuaPost = builtins.readFile ./keybinds.lua;

}
