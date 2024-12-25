{ config, pkgs, lib, home-manager, ... }:

let
    user = "lol";
in
{
    users.users.${user} = {
        name = "${user}";
        home = "/Users/${user}";
        isHidden = false;
        shell = pkgs.zsh;
    };
    
    # Nix-darwin homebrew module.
    # Base homebrew configuration is done via nix-homebrew
    homebrew = {
        enable = true;
        casks = pkgs.callPackage ./casks.nix {};
        
        # https://github.com/mas-cli/mas
        # $ nix shell nixpkgs#mas
        # $ mas search <app>
        masApps = {};
    };

    home-manager = {
        useGlobalPkgs = true;
        users.${user} = { pkgs, config, lib, ... }:{
            home = {
                enableNixpkgsReleaseCheck = false;
                packages = pkgs.callPackage ./packages.nix {};
                # Fix emacs
                stateVersion = "23.11";
            };
        };
    };
}
