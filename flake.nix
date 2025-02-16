{
    description = "TNH nix configuration for MacOS";

    outputs = inputs: import ./outputs inputs;

    nixConfig = {
        # For later use
        extra-substituters = [];
        extra-trusted-public-keys = [];
    };

    inputs = {
        # Offical NixOS package source, by default unstable
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

        # MacOS package source
        nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs-darwin";
        };
        nixos-hardware.url = "github:NixOS/nixos-hardware/master"; # Not used atm

        # Homebrew
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
        
        # HomeManager for management of user configs
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # haumea = {
        #     url = "github:nix-community/haumea/v0.2.2";
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };

        # My own repos
    };
}
