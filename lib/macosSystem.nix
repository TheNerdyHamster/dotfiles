{
    lib,
    inputs,
    darwin-modules,
    home-modules ? [],
    system,
    genSpecialArgs,
    specialArgs ? (genSpecialArgs system),
    ...
}: let
    inherit (inputs) nixpkgs-darwin home-manager darwin;
in
    darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules =
            darwin-modules
            ++ [
                ({lib, ...}: {
                    nixpkgs.pkgs = import nixpkgs-darwin {inherit system;};
                 })
            ]
            ++ (
                lib.optionals ((lib.lists.length home-modules) > 0)
                [
                    home-manager.darwinModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.backupFileExtension = "bak";

                        home-manager.extraSpeialArgs = specialArgs;
                        home-manager.users.lol.imports = home-modules;
                    }
                ]
            );
    }
