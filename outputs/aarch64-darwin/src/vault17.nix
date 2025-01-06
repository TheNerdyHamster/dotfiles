{
    inputs,
    lib,
    system,
    genSpecialArgs,
    specialArgs ? (genSpecialArgs system),
    ...
} @ args: let
    name = "vault-17";

    inherit (inputs) nixpkgs-darwin home-manager darwin;
    
    #modules = {};
in {
    darwinConfigurations.${name} = darwin.lib.darwinSystem{
        inherit system specialArgs;
        modules = [
            home-manager.darwinModules.home-manager
            # temporary
            {
                system.stateVersion = 5;
            }
        ];
    };
}
