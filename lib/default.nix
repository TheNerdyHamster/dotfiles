{lib, ...}: {
    macosSystem = import ./macosSystem.nix;

    attrs = import ./attrs.nix {inherit lib;};

    relativeToRoot = lib.path.append ../.;
    scanPaths = path:
        builtins.map
        (f: (path + "/${f}"))
        (builtins.attrNames
            (lib.attrsets.filterAttrs
                (path: _type:
                    (_type == "directory")
                    #&& (path != "homebrew")
                    || (
                        (path != "default.nix")
                        && (lib.strings.hasSuffix ".nix" path)
                    )
                )
            (builtins.readDir path)));
}
