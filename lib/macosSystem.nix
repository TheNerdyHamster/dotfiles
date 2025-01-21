{
    lib,
    inputs,
    darwin-modules,
    #homebrew-modules ? [],
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

                        home-manager.extraSpecialArgs = specialArgs;
                        home-manager.users.lol.imports = home-modules;
                    }
                ]
            );
            # Will try to figure out this at a later point
            # ++ (
            #     lib.optionals ((lib.lists.length homebrew-modules) > 0)
            #     # (map (config: nix-homebrew.darwinModules.nix-homebrew config) homebrew-modules)
            #     [
            #         nix-homebrew.darwinModules.nix-homebrew {
            #             nix-homebrew = homebrew-modules;
            #         }
            #     ]
            # );
    }
