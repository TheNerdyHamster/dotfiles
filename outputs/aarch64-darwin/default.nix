{
    lib,
    inputs,
    ...
} @ args: let
    # Recursively load all nix files from src dir.
    loadSrc = src: let
        files = builtins.filter (f: builtins.match ".*\\.nix$" f != null) (builtins.attrNames (builtins.readDir src));
    in
        builtins.listToAttrs (map (file: {
            name = lib.removeSuffix ".nix" file;
            value = import "${src}/${file}" args;
        }) files);

    src = ./src;
    data = loadSrc src;

    dataWithoutPaths = builtins.attrValues data;

    # Merge all machines data into one attr set.
    outputs = {
        darwinConfigurations = lib.attrsets.mergeAttrsList (map (it: it.darwinConfigurations or {}) dataWithoutPaths);
    };
in
    outputs
    // {
        inherit data;
    }
