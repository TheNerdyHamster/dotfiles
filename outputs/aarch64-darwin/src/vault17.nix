{
    inputs,
    lib,
    mylib,
    myvars,
    system,
    genSpecialArgs,
    specialArgs ? (genSpecialArgs system),
    ...
} @ args: let
    name = "vault-17";

    inherit (inputs) nixpkgs-darwin home-manager darwin;

    #homebrew_module = "./modules/darwin/homebrew";
    
    modules = {
        darwin-modules =
            (map mylib.relativeToRoot [
                "modules/darwin"
            ])
            ++ [];
        # Will fix this later
        #homebrew-modules = import /modules/darwin/homebrew;
        # homebrew-modules = import (builtins.path {
        #     path = lib.path.append "../." "modules/darwin/homebrew";
        # });
        # homebrew-modules = import ./modules/darwin/homebrew/default.nix;
            # (map mylib.relativeToRoot [
            #     "modules/darwin/homebrew"
            # ])
            # ++ [];
    };

    systemArgs = modules // args;
in {
    darwinConfigurations.${name} = mylib.macosSystem systemArgs;
}
