{
    description = "TNH Base configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:LnL7/nix-darwin";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .
        darwinConfigurations."vault-17" = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            specialArgs = { inherit inputs self; };
            modules = [ 
                "./hosts/vault17/default.nix"
            ];
        };
    };
}
