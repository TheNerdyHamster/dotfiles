{
    inputs,
    outputs,
    stateVersion,
}:
{
    # Helper function to generate home-manager config;
    mkHome = {
        hostname,
        username ? "lol",
        email ? "unkown@changeme.local",
        laptop ? true,
        platform ? "x86_64-linux",
    }:
    let
        isISO = builtins.substring 0 4 hostname == "iso-";
        isInstall = !isISO;
        isLaptop = laptop;
    in
    inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${platform};
        extraSpecialArgs = {
            inherit
                inputs
                outputs
                hostname
                platform
                username
                email
                stateVersion
                isISO
                isInstall
                isLaptop
                ;
        };
        modules = [ ../home-manager ];
    };

    mkDarwin = {
        desktop ? "",
        hostname,
        username ? "lol",
        platform ? "aarch64-darwin",
    }:
    let
        isISO = false;
        isInstall = true;
        isLaptop = true;
    in
    inputs.nix-darwin.lib.darwinSystem {
        specialArgs = {
            inherit
                inputs
                outputs
                hostname
                platform
                username
                isInstall
                isISO
                isLaptop
                ;
        };
        modules = [ ../darwin ];
    };

    forAllSystems = inputs.nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-linux"
        "aarch64-linux"
    ];
}
