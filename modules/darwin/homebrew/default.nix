{self, myvars, nix-homebrew, ...} @inputs:
{
    nix-homebrew = {
        enable = true;
        autoMigrate = true;
        user = "${myvars.username}";
        onActivation = {
            autoUpdate = true;
            upgrade = true;
            cleanup = "zap";
        };

        mutableTaps = false;
        taps = {
            "homebrew/homebrew-core" = inputs.homebrew-core;
        };
    };
}
