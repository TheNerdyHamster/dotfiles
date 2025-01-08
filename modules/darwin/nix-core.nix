{
    # Yes we will allow unfree packages.
    nixpkgs.config.allowUnfree = true;

    services.nix-daemon.enable = true;

    nix.settings.auto-optimise-store = false;
    nix.gc.automatic = false;

    system.stateVersion = 5;
}
