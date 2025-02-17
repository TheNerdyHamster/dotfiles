{ lib, ...}:
let
    currentDir = ./.;
    isNotTemplate = name: type: type == "directory" && name != "_template";
    directories = lib.filterAttrs isNotTemplate (builtins.readDir currentDir);
    importDirectory = name: import (currentDir + "/${name}");
in
{
    imports = lib.mapAttrsToList (name: _: importDirectory name) directories;
}
