{
    description = "TNH Base configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
        homebrew-bundle = {
            url = "github:homebrew/homebrew-bundle";
            flake = false;
        };
        homebrew-core = {
            url = "github:homebrew/homebrew-core";
            flake = false;
        };
        homebrew-cask = {
            url = "github:homebrew/homebrew-cask";
            flake = false;
        };
        homebrew-services = {
            url = "github:homebrew/homebrew-services";
            flake = false;
        };
        felixkratz-formulae = {
            url = "github:felixkratz/homebrew-formulae";
            flake = false;
        };
        nikitabobko-tap= {
            url = "github:nikitabobko/homebrew-tap";
            flake = false;
        };
        darwin-emacs = {
            url = "github:c4710n/nix-darwin-emacs";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        darwin-emacs-packages = {
            url = "github:nix-community/emacs-overlay";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, darwin, nixpkgs, home-manager, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, homebrew-services, felixkratz-formulae, nikitabobko-tap, darwin-emacs, darwin-emacs-packages } @inputs:
    let
        user = "lol";
    in
    {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .
        darwinConfigurations."vault-17" = darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            specialArgs = { inherit inputs self; };
            modules = [ 
                home-manager.darwinModules.home-manager
                nix-homebrew.darwinModules.nix-homebrew
                {
                    nix-homebrew = {
                        # inherit user;
                        enable = true;
                        taps = {
                            "homebrew/homebrew-core" = homebrew-core;
                            "homebrew/homebrew-cask" = homebrew-cask;
                            "homebrew/homebrew-bundle" = homebrew-bundle;
                            "homebrew/homebrew-services" = homebrew-services;
                            "felixkratz/homebrew-formulae" = felixkratz-formulae; # Might remove
                            "nikitabobko/homebrew-tap" = nikitabobko-tap; # Remove as its no longer in use
                        };
                        mutableTaps = false;
                        user = "${user}";
                        autoMigrate = true;
                    };
                    nixpkgs = {
                        overlays = [
                            darwin-emacs.overlays.emacs
                            darwin-emacs-packages.overlays.package
                        ];
                    };
                }
                ./hosts/vault17
            ];
        };
    };
}
