{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = 
  { self, nix-darwin, nixpkgs, ...}@inputs:
  let
    inherit (self) outputs;

    stateVersion = "24.11";
    helper = import ./lib { inherit inputs outputs stateVersion; };
  in
  {
      homeConfigurations = {
        # "lol@vault-17" = helper.mkHome {
        #     hostname = "vault-17";
        #     platform = "aarch64-darwin";
        # };
        # "Leo.Olofsson@vault-17" = helper.mkHome {
        #     hostname = "vault-17";
        #     platform = "aarch64-darwin";
        # };
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
