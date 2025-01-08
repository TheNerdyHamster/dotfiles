{
    inputs,
    lib,
    mylib,
    system,
    genSpecialArgs,
    specialArgs ? (genSpecialArgs system),
    ...
} @ args: let
    name = "vault-17";

    inherit (inputs) nixpkgs-darwin home-manager darwin;
    
    modules = {
        darwin-modules =
            (map mylib.relativeToRoot [
                "modules/darwin"
            ])
            ++ [];
    };

    systemArgs = modules // args;
in {
    darwinConfigurations.${name} = mylib.macosSystem systemArgs;
}
