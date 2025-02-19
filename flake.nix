{
  description = "Example nix-darwin system flake";

  inputs = {
    # Offical NixOS package source, by default unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Nix needs reboot
    nixos-needsreboot.url = "https://flakehub.com/f/wimpysworld/nixos-needsreboot/0.2.5.tar.gz";
    nixos-needsreboot.inputs.nixpkgs.follows = "nixpkgs";
    # Homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # Nix index database
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    # Sops
    sops-nix.url = "https://flakehub.com/f/Mic92/sops-nix/0.1.887.tar.gz";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = 
  { self, nix-darwin, nixpkgs, ...}@inputs:
  let
    inherit (self) outputs;

    stateVersion = "25.05";
    helper = import ./lib { inherit inputs outputs stateVersion; };
  in
  {
      homeConfigurations = {
        "lol@vault-17" = helper.mkHome {
            hostname = "vault-17";
            platform = "aarch64-darwin";
        };
        "lol@vault-19" = helper.mkHome {
            hostname = "vault-19";
            platform = "aarch64-darwin";
        };
      };
      darwinConfigurations = {
          vault-17 = helper.mkDarwin {
              hostname = "vault-17";
          };
          vault-19 = helper.mkDarwin {
              hostname = "vault-19";
          };
      };
    formatter = helper.forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
  };
}
