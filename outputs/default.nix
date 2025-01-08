{
    self,
    nixpkgs,
    ...
} @ inputs: let
    inherit (inputs.nixpkgs) lib;
    mylib = import ../lib {inherit lib;};
    myvars = import ../vars {inherit lib;};

    genSpecialArgs = system:
        inputs
        // {
            inherit mylib myvars;

            pkgs-unstable = import inputs.nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
            };
            pkgs-stable = import inputs.nixpkgs-stable {
                inherit system;
                config.allowUnfree = true;
            };
        };

    args = {inherit inputs lib mylib myvars genSpecialArgs; };

    nixosSystems = {
        #x86_64-linux = import ./x86_64-linux (args // {system = "x86_64-linux";});
    };
    darwinSystems = {
        aarch64-darwin = import ./aarch64-darwin (args // {system = "aarch64-darwin";});
    };

    allSystems = nixosSystems // darwinSystems;
    allSystemNames = builtins.attrNames allSystems;
    nixosSystemValues = builtins.attrValues nixosSystems;
    darwinSystemValues = builtins.attrValues darwinSystems;
    allSystemValues = nixosSystemValues ++ darwinSystemValues;

    forAllSystems = func: (nixpkgs.lib.genAttrs allSystemNames func);
in {
    debugAttrs = {inherit nixosSystems darwinSystems allSystems allSystemNames;};

    # Darwin hosts
    darwinConfigurations = lib.attrsets.mergeAttrsList (map (it: it.darwinConfigurations or {}) darwinSystemValues);

    packages = forAllSystems (
        system: allSystems.${system}.packages or {}
    );
}
